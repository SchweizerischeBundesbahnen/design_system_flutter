# Principles

These principles guide our development and help our consumers understand what to expect from this package.
While aligned with the broader SBB design vision, they focus specifically on developer experience rather
than the general design principles found at [digital.sbb.ch/principles](https://digital.sbb.ch/de/principles/ux-principles/overview/).

## Aim for Convenience

Our goal is to enable consumers to build SBB-themed applications with minimal friction. This means providing intuitive parameters—such as
`labelText` or `iconData`—that let you create properly styled widgets without worrying about theming or styling details. We achieve this
through carefully chosen **sensible defaults** that match real-world use cases.

Consumers should be able to implement
[Figma components](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12&p=f)
with minimal effort and thought.

## Customization

Customization is supported to a meaningful extent, particularly for composite widgets like `SBBListItem` that contain other widgets. We
maintain three key principles:

* **Colors and spacing** are easily customizable across all components, backed by clear documentation for each variant.
* **Default geometric values** are accessible and transparent.
* **Fine-grained geometric adjustments** can be made for edge cases, though with minimal guidance.

This reflects a careful balance: we avoid forcing consumers into rigid constraints, yet prevent over-customization that strays from the
original design intent. We navigate this balance through community feedback and ongoing collaboration with our UX design team.

## Aim for a Boring API

We deliberately favor predictable, straightforward APIs over clever or feature-rich ones. A "boring" API is one that behaves as you'd
expect.

This principle stems from the understanding that less cognitive overhead means fewer bugs and faster development. When an API is boring,
consumers can focus on building features rather than deciphering behavior. We embrace
the [Principle of Least Surprise](https://en.wikipedia.org/wiki/Principle_of_least_astonishment), ensuring that component behavior aligns
with consumer expectations.

In practice, this means:

* **Clear naming**: Method and parameter names accurately reflect what they do.
* **Consistent patterns**: Similar components behave similarly; no hidden exceptions.
* **Predictable defaults**: Default values work for the most common use cases without side effects.
* **Explicit over implicit**: Opt-in features rather than magical behavior that requires opting out.

