# Repository Coding Standards

The purpose of the Coding Standards is to create a baseline for collaboration and review within various aspects of our open source project and community, from core code to themes to plugins.

Coding standards help avoid common coding errors, improve the readability of code, and simplify modification. They ensure that files within the project appear as if they were created by a single common unit.

Following the standards means anyone will be able to understand a section of code and modify it, if needed, without regard to when it was written or by whom.

If you are planning to contribute, you need to familiarize yourself with these standards, as any code you submit will need to comply with them.

## Coding standards

Please refer to the following guideline for detailed recommendations:

[Style guide for Flutter](https://github.com/flutter/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md)

## Code style

Your code should adhere to the effective [dart style](https://dart.dev/effective-dart/style).

## Code formatting

According to the above recommended style, we check our code for formatting with the `dart format` cli in our CI
(before running src code generation, e.g. Mocks).
The only deviation is a line length of
`100` compared to the standard guide. If your code does not follow these standards,
the CI will fail. We run this step:

```yml
- name: Format check
  run: dart format --page-width 100 -o none --set-exit-if-changed .
```