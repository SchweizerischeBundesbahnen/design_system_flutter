#!/usr/bin/env node
/**
 * Script to analyze the design system Flutter project and find public classes
 * that are not prefixed with "SBB".
 */

const fs = require('fs');
const path = require('path');

// Constants
const PROJECT_ROOT = '.';
const MAIN_BARREL_FILE = path.join(PROJECT_ROOT, 'lib', 'sbb_design_system_mobile.dart');
const WHITELIST_FILE = path.join(__dirname, 'whitelisted_names.txt');

// Regex patterns
const EXPORT_PATTERN = /export\s+['"](.+?)['"];/;
const CLASS_PATTERN = /^\s*(?:abstract\s+)?(?:final\s+)?class\s+([A-Z_]\w*)\s*(?:\{|extends|implements|with|<)/;
const MIXIN_PATTERN = /^\s*mixin\s+([A-Z_]\w*)\s*(?:\{|on|<)/;
const EXTENSION_PATTERN = /^\s*extension\s+([A-Z_]\w*)\s*(?:\{|on|<)/;

/**
 * Read a file and return its lines
 * @param {string} filePath - Path to the file
 * @returns {string[]} Array of lines
 */
function readFile(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf-8');
    return content.split('\n');
  } catch (error) {
    console.error(`Error reading ${filePath}: ${error.message}`);
    return [];
  }
}

/**
 * Load whitelisted names from file
 * @returns {Set<string>} Set of whitelisted names
 */
function loadWhitelist() {
  const whitelist = new Set();

  if (!fs.existsSync(WHITELIST_FILE)) {
    return whitelist;
  }

  const lines = readFile(WHITELIST_FILE);
  for (const line of lines) {
    const trimmed = line.trim();
    // Skip empty lines and comments
    if (trimmed && !trimmed.startsWith('#') && !trimmed.startsWith('//')) {
      whitelist.add(trimmed);
    }
  }

  return whitelist;
}

/**
 * Extract export paths from Dart file lines
 * @param {string[]} lines - Lines of the file
 * @returns {string[]} Array of export paths
 */
function extractExports(lines) {
  const exports = [];
  for (const line of lines) {
    const match = line.match(EXPORT_PATTERN);
    if (match) {
      exports.push(match[1]);
    }
  }
  return exports;
}

/**
 * Extract public classes, mixins, and extensions from Dart file
 * @param {string[]} lines - Lines of the file
 * @param {string} filePath - Path to the file
 * @returns {Object} Object with keys 'classes', 'mixins', 'extensions'
 */
function extractPublicTypes(lines, filePath) {
  const typesDict = {
    classes: [],
    mixins: [],
    extensions: []
  };

  for (let lineNum = 0; lineNum < lines.length; lineNum++) {
    const line = lines[lineNum];

    // Skip comments
    if (line.trim().startsWith('//')) {
      continue;
    }

    // Check for classes
    const classMatch = line.match(CLASS_PATTERN);
    if (classMatch) {
      const className = classMatch[1];
      // Only include public classes (not starting with underscore)
      if (!className.startsWith('_')) {
        typesDict.classes.push([className, lineNum + 1]);
      }
      continue;
    }

    // Check for mixins
    const mixinMatch = line.match(MIXIN_PATTERN);
    if (mixinMatch) {
      const mixinName = mixinMatch[1];
      if (!mixinName.startsWith('_')) {
        typesDict.mixins.push([mixinName, lineNum + 1]);
      }
      continue;
    }

    // Check for extensions
    const extensionMatch = line.match(EXTENSION_PATTERN);
    if (extensionMatch) {
      const extensionName = extensionMatch[1];
      if (!extensionName.startsWith('_')) {
        typesDict.extensions.push([extensionName, lineNum + 1]);
      }
      continue;
    }
  }

  return typesDict;
}

/**
 * Resolve a relative export path to an absolute file path
 * @param {string} exportPath - Relative export path
 * @param {string} baseFile - Base file path
 * @returns {string} Resolved absolute path
 */
function resolveExportPath(exportPath, baseFile) {
  const libDir = path.dirname(baseFile);
  return path.join(libDir, exportPath);
}

/**
 * Analyze a barrel file (file with exports) and recursively follow exports
 * @param {string} filePath - Path to the barrel file
 * @param {number} indent - Indentation level
 * @returns {Object} Analysis results
 */
function analyzeBarrelFile(filePath, indent = 0) {
  const results = {
    file: filePath,
    exports: [],
    types: {},
    issues: []
  };

  if (!fs.existsSync(filePath)) {
    results.issues.push(`File not found: ${filePath}`);
    return results;
  }

  const lines = readFile(filePath);
  if (lines.length === 0) {
    results.issues.push(`Could not read file: ${filePath}`);
    return results;
  }

  // Extract types from this file
  const types = extractPublicTypes(lines, filePath);
  results.types = types;

  // Extract exports
  const exports = extractExports(lines);

  for (const exportPath of exports) {
    const resolvedPath = resolveExportPath(exportPath, filePath);

    // Check if this is a barrel file (contains exports) or a regular file
    const exportLines = readFile(resolvedPath);
    const isBarrel = exportLines.some(line => EXPORT_PATTERN.test(line));

    if (isBarrel) {
      // Recursively analyze barrel file
      const subResults = analyzeBarrelFile(resolvedPath, indent + 1);
      results.exports.push(subResults);
    } else {
      // Analyze regular file
      const exportTypes = extractPublicTypes(exportLines, resolvedPath);
      results.exports.push({
        file: resolvedPath,
        types: exportTypes,
        isBarrel: false
      });
    }
  }

  return results;
}

/**
 * Find types that are public and not prefixed with "SBB"
 * @param {Object} typesDict - Dictionary of types
 * @param {Set<string>} whitelist - Set of whitelisted names
 * @returns {Array} Array of [typeName, typeKind, lineNum] tuples
 */
function findNonSBBPrefixed(typesDict, whitelist) {
  const issues = [];

  for (const typeKind of ['classes', 'mixins', 'extensions']) {
    const typeList = typesDict[typeKind] || [];
    for (const [typeName, lineNum] of typeList) {
      if (!typeName.startsWith('Sbb') && !typeName.startsWith('SBB')) {
        // Check if it's whitelisted
        if (!whitelist.has(typeName)) {
          issues.push([typeName, typeKind, lineNum]);
        }
      }
    }
  }

  return issues;
}

/**
 * Pretty print the analysis results
 * @param {Object} results - Analysis results
 * @param {number} indent - Indentation level
 * @param {Set<string>} whitelist - Set of whitelisted names
 */
function printResults(results, indent = 0, whitelist = new Set()) {
  const indentStr = '  '.repeat(indent);

  console.log(`${indentStr}📄 File: ${results.file}`);

  // Print types found in this file
  const types = results.types || {};
  for (const typeKind of ['classes', 'mixins', 'extensions']) {
    const typeList = types[typeKind] || [];
    if (typeList.length > 0) {
      console.log(`${indentStr}  ${typeKind.toUpperCase()}:`);
      for (const [typeName, lineNum] of typeList) {
        const hasSBB = typeName.startsWith('SBB') || typeName.startsWith('Sbb');
        const isWhitelisted = whitelist.has(typeName);

        let prefix;
        if (hasSBB) {
          prefix = '✅';
        } else if (isWhitelisted) {
          prefix = '⚠️';
        } else {
          prefix = '❌';
        }

        console.log(`${indentStr}    ${prefix} ${typeName} (line ${lineNum})`);
      }
    }
  }

  // Recursively print exported files
  const exports = results.exports || [];
  if (exports.length > 0) {
    console.log(`${indentStr}  Exports:`);
    for (const exportResult of exports) {
      printResults(exportResult, indent + 2, whitelist);
    }
  }
}

/**
 * Collect all issues from results recursively
 * @param {Object} results - Analysis results
 * @param {Array} issuesList - List to collect issues
 * @param {Array} whitelistedList - List to collect whitelisted items
 * @param {Set<string>} whitelist - Set of whitelisted names
 */
function collectIssues(results, issuesList, whitelistedList, whitelist) {
  const types = results.types || {};

  for (const typeKind of ['classes', 'mixins', 'extensions']) {
    const typeList = types[typeKind] || [];
    for (const [typeName, lineNum] of typeList) {
      if (!typeName.startsWith('Sbb') && !typeName.startsWith('SBB')) {
        if (whitelist.has(typeName)) {
          whitelistedList.push([results.file, typeName, typeKind, lineNum]);
        } else {
          issuesList.push([results.file, typeName, typeKind, lineNum]);
        }
      }
    }
  }

  for (const exportResult of results.exports || []) {
    collectIssues(exportResult, issuesList, whitelistedList, whitelist);
  }
}

/**
 * Main function
 */
function main() {
  console.log('='.repeat(80));
  console.log('Design System Flutter - Naming Analysis');
  console.log('='.repeat(80));
  console.log();

  if (!fs.existsSync(MAIN_BARREL_FILE)) {
    console.error(`Error: Main barrel file not found at ${MAIN_BARREL_FILE}`);
    process.exit(1);
  }

  // Load whitelist
  const whitelist = loadWhitelist();
  if (whitelist.size > 0) {
    console.log(`Loaded ${whitelist.size} whitelisted name(s):`);
    for (const name of whitelist) {
      console.log(`  - ${name}`);
    }
    console.log();
  }

  console.log(`Analyzing main barrel file: ${MAIN_BARREL_FILE}`);
  console.log();

  const results = analyzeBarrelFile(MAIN_BARREL_FILE);
  printResults(results, 0, whitelist);

  console.log();
  console.log('='.repeat(80));
  console.log('SUMMARY - Non-SBB Prefixed Public Types');
  console.log('='.repeat(80));
  console.log();

  // Collect all issues and whitelisted items
  const allIssues = [];
  const allWhitelisted = [];
  collectIssues(results, allIssues, allWhitelisted, whitelist);

  // Display whitelisted items
  if (allWhitelisted.length > 0) {
    console.log('Whitelisted types (not prefixed with SBB):');
    console.log();
    allWhitelisted.sort();
    for (const [filePath, typeName, typeKind, lineNum] of allWhitelisted) {
      console.log(`⚠️  ${filePath}`);
      console.log(`   Line ${lineNum}: ${typeKind.toUpperCase()} '${typeName}' is whitelisted`);
      console.log();
    }
  }

  if (allIssues.length > 0) {
    console.log('Naming violations:');
    console.log();
    allIssues.sort();
    for (const [filePath, typeName, typeKind, lineNum] of allIssues) {
      console.log(`❌ ${filePath}`);
      console.log(`   Line ${lineNum}: ${typeKind.toUpperCase()} '${typeName}' is not prefixed with 'SBB'`);
      console.log();
    }
    console.error(`Found ${allIssues.length} naming violation(s).`);
    process.exit(1);
  } else {
    console.log('✅ All public types are properly prefixed with \'SBB\' or whitelisted!');
    process.exit(0);
  }
}

// Run main function
if (require.main === module) {
  main();
}

module.exports = {
  analyzeBarrelFile,
  extractPublicTypes,
  findNonSBBPrefixed,
  loadWhitelist
};

