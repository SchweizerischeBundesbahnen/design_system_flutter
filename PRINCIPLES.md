# Principles

These principles guide us in the development and help clients understand what to expect from this package.
They are more directly targeted at developers than the principles found in
[digital.sbb.ch/principles](https://digital.sbb.ch/de/principles/ux-principles/overview/).

## Aim for Convenience

The goal of this package is to allow clients to setup an SBB themed app with all components as quickly as possible.
This implies having convenience parameters like `labelText` or `iconData` to build SBB styled widgets without
thinking much about theming or styling. This is achieved by delivering accurate and understandable
**default values**.

Clients should be able to build the
[Figma components](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12&p=f)
as easily as possible.

## Customization

Clients are allowed to customize components to a certain extent. This mostly concerns widgets that contain other
widgets (e.g. `SBBListItem`). There are three important aspects here:

* **Coloring** and inner padding are easily customizable for all components, meaning good documentation and per individual component
* Geometric default values should be accessible for reading
* Geometric values can be customized in edge cases, but there is little documentation or guidance given

The result of the above is a fine borderline between complete custom widgets, that have little to do with the original intent of the component designers and
being too rigid for a real world application. We walk this line by listening to community feedback and constant exchange with the UX designers.
