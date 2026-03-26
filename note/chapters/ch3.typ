#import "@preview/cetz:0.3.4": canvas, draw

#set math.equation(numbering: "(3.1)")

= The central charge and the Virasoro algebra

In this chapter, our goal is to construct the Hilbert space in CFT. we will introduce the Virasoro algebra, which is a central extension of the Witt algebra, also the building block of Hilbert space. The Virasoro algebra plays a crucial role in two-dimensional conformal field theories (CFTs) and string theory. We will also discuss the concept of the central charge, which can be used to distinguish different CFTs.

== Review of chapter 2
From now on and later, we only focus on two-dimensional CFTs. In chapter 2, we introduced the stress-energy tensor, its properties, Radial quantization, definition of primary field and Ward identities. 

=== The stress-energy tensor
In 2D CFT, we have stress-energy tensor $T(z)$ and $overline(T)(overline(z))$, which are holomorphic and anti-holomorphic, respectively. They satisfy the following properties:
- $"Traceless:" T_(z overline(z)) = T_(overline(z) z) =0$
- $"Symmetric:" T_(mu nu) = T_(nu mu) $

And combined with the conservation law $partial^mu T_(mu nu) = 0$, we can derive that $T(z)$ is holomorphic and $overline(T)(overline(z))$ is anti-holomorphic $partial_(overline(z)) T_(z z) = partial_(z) T_(overline(z) overline(z)) = 0 $. Thus we could write $T(z) = T_(z z)$ and $overline(T)(overline(z)) = T_(overline(z) overline(z))$.

=== Radial quantization
Then we have introduced the radial quantization, basically map the complex plane to a cylinder, where the radial direction corresponds to the time direction. In this way, we can define the in- and out-states as the states at $r -> 0$ and $r -> infinity$, respectively. The radial quantization allows us to compute correlation functions and commutators in a more convenient way.

#figure(
  canvas(length: 1cm, {
    import draw: *
    set-style(stroke: 1.1pt)

    // ---------- LEFT: cylinder ----------
    let c = (-7.5, 0.0)
    let w = 5.8
    let rx = 0.85
    let ry = 1.25

    // end caps (ellipses)
    content((c.at(0) - w / 2, c.at(1)), ellipse(width: 1.7cm, height: 2.5cm, fill: none, stroke: 1.1pt))
    content((c.at(0) + w / 2, c.at(1)), ellipse(width: 1.7cm, height: 2.5cm, fill: none, stroke: 1.1pt))

    line((c.at(0) - w / 2, c.at(1) + ry), (c.at(0) + w / 2, c.at(1) + ry))
    line((c.at(0) - w / 2, c.at(1) - ry), (c.at(0) + w / 2, c.at(1) - ry))

    // slices inside cylinder (dotted ellipses)
    content(
      (c.at(0) - 1.45, c.at(1)),
      ellipse(width: 1.24cm, height: 2.44cm, fill: none, stroke: (paint: red, dash: "dotted", thickness: 1pt)),
    )
    content(
      (c.at(0) + 0.95, c.at(1)),
      ellipse(width: 1.24cm, height: 2.44cm, fill: none, stroke: (paint: red, dash: "dotted", thickness: 1pt)),
    )

    // // dashed back edge on right cap (shifted left, protruding into cylinder)
    // arc(
    //   (c.at(0) + w / 2 - 0.5, c.at(1)+ w / 4- 0.15),
    //   radius: ry,
    //   start: 115deg,
    //   stop: 245deg,
    //   stroke: (dash: "dashed"),
    // )

    content((c.at(0) - 0.85, -1.55), [$t_1$])
    content((c.at(0) + 1.55, -1.55), [$t_2$])
    content((c.at(0) + 1.45, -2.35), [$xi = t + i x$])

    // space-direction curved arrow (shifted left/up, parallel to cylinder boundary)
    arc(
      (c.at(0) - w / 2 - 0.7, c.at(1) ),
      radius: 0.46,
      start: 200deg,
      stop: 90deg,
      mark: (end: ">"),
    )
    content((c.at(0) - w / 2 - 0.18, c.at(1) + 0.20), [$x$])

    // time-direction arrow: horizontal and parallel to cylinder
    line(
      (c.at(0) - w / 2 - 0.5, c.at(1) - 2.10),
      (c.at(0) - w / 2 + 2.0, c.at(1) - 2.10),
      mark: (end: ">"),
    )
    content((c.at(0) - w / 2 + 1.5, c.at(1) - 2.45), [$t$])

    // ---------- MIDDLE ----------
    let a1 = (-2.4, 0.0)
    let a2 = (1.0, 0.0)
    line(a1, a2, stroke: (paint: rgb("#1d6d93"), thickness: 2pt), mark: (end: ">"))
    content((-0.8, 0.62), [$xi -> z = e^(2 pi xi / L)$])

    let a1 = (-2.4, -0.4)
    let a2 = (1.0, -0.4)
    line(a1, a2, stroke: (paint: rgb("#1d6d93"), thickness: 2pt), mark: (start: ">"))
    content((-0.8, -0.8), [$z -> xi = L/(2pi) ln z$])

    // ---------- RIGHT: complex plane ----------
    let p = (4.6, 0.0)
    circle(p, radius: 1.75)
    circle(p, radius: 1.35, stroke: (paint: red, dash: "dashed"))
    circle(p, radius: 0.92, stroke: (paint: red, dash: "dashed"))
    circle(p, radius: 0.55, stroke: (dash: "dashed"))

    line((p.at(0), p.at(1)), (p.at(0) + 2.35, p.at(1)), mark: (end: ">"))
    line((p.at(0), p.at(1)), (p.at(0), p.at(1) + 2.25), mark: (end: ">"))
    content((p.at(0) + 2.55, p.at(1) - 0.05), [$z_0$])
    content((p.at(0) - 0.05, p.at(1) + 2.45), [$z_1$])

    content((p.at(0) + 0.75, p.at(1) - 0.55), [$t_1$])
    content((p.at(0) + 0.95, p.at(1) - 0.95), [$t_2$])
  }),
  caption: [Conformal map between cylinder and complex-plane],
)

From above figure, we can see that the time translation $t arrow.r t+lambda$ along the cylinder's axis corresponds to the scale transformation $z arrow.r e^(2pi lambda / L) z$ on the complex plane. And the spatial translation $x arrow.r x + lambda$ along the cylinder corresponds to the rotation $z arrow.r e^(2pi i lambda / L) z$ on the complex plane. Thus, the generator of time translation on the cylinder, which is the energy operator Hamiltonian $H$, corresponds to the generator of scale transformation on the complex plane, which is the dilatation operator $D$. Similarly, the generator of spatial translation on the cylinder, momentum operator $P$, corresponds to the generator of rotation on the complex plane $S$. Their spectrum also corresponds to each other. We could have below table for the correspondence between the generators and their spectrum:

#table(
  columns: 2,
  align: (left, left),
  stroke: 0.6pt,
  inset: 6pt,
  table.header(
    [*Cylinder*],
    [*Complex plane*],
  ),
  [Time translation $t arrow.r t + lambda$],
  [Scale transformation $z arrow.r e^(2pi lambda / L) z$],
  [Spatial translation $x arrow.r x + lambda$],
  [Rotation $z arrow.r e^(2pi i lambda / L) z$],
  [Hamiltonian $H$],
  [Dilatation operator $D$],
  [Momentum operator $P$],
  [Rotation operator $S$],
  [Spectrum of $H$: energy $E_n$],
  [Spectrum of $D$: scaling dimension $Delta_n$],
  [Spectrum of $P$: momentum $k_n$],
  [Spectrum of $S$: conformal spin $s_n$],
)

The radial quantization allows us to compute the commutator in the form: $ [A, B] = integral.cont_0 d w integral.cont_w d z a(z) b(w)$, where $a(z)$ and $b(w)$ are $integral.cont a(z) d z$ and $integral.cont b(w) d w$, respectively. The contour integrals are taken around the origin and the point $w$, respectively.

=== Ward identities
The Ward identities are the consequences of the symmetries of the theory, which can be derived from the conservation of the stress-energy tensor. They relate the correlation functions of the stress-energy tensor with the correlation functions of the primary fields. The Ward identities can be used to compute the correlation functions of the primary fields, which are the building blocks of the CFT.

=== Primary fields
The primary fields are the fields that transform covariantly under the conformal transformations. They are defined as the fields that satisfy the following transformation law under the conformal transformation $z arrow.r f(z)$:
$ phi(z) arrow.r (partial f(z))^h (partial overline(f)(overline(z)))^h overline(phi)(overline(z)) $
where $h$ and $overline(h)$ are the conformal weights of the primary field $phi(z, overline(z))$. The primary fields are the highest-weight states of the Virasoro algebra, which we will introduce in the next section. The correlation functions of the primary fields can be computed using the Ward identities, and they have a specific form determined by the conformal symmetry.

== Outline of this chapter
- Virasoro algebra: $[L_m, L_n] = (m-n)L_(m+n) + frac(c, 12) m(m^2-1) delta_(m+n,0)$
- Primary fields: $[L_n, phi(z)] = z^n (z partial + (n+1) h) phi(z)$
- Highest-weight states: $L_n |h> = 0$ for $n > 0$, $L_0 |h> = h |h>$
- Descendant fields: $[L_n, partial^k phi(z)] = z^n (z partial + (n+1) (h+k)) partial^k phi(z)$

== The free bosons
Here we review the basic properties of free bosons, which are the simplest example of CFTs. The free boson theory is described by a scalar field $phi(z, overline(z))$ with the action:
$ S = frac(1,4pi) integral d^2z partial phi(z, overline(z)) partial phi(z, overline(z)) $

The stress-energy tensor for the free boson theory can be derived from the action using the Noether procedure, and it is given by:
$ T(z) = -frac(1,2) :partial phi(z) partial phi(z): $
$ overline(T)(overline(z)) = -frac(1,2) :overline(partial) phi(overline(partial)) overline(partial) phi(overline(z)): $
The free boson theory has a central charge of $c = 1$.

== The free fermions
The free fermion theory is described by a fermionic field $psi(z)$ with the action:
$ S = frac(1,2pi) integral d^2z psi(z) overline(partial) psi(z) $
The stress-energy tensor for the free fermion theory can be derived from the action using the Noether procedure, and it is given by:
$ T(z) = -frac(1,2) :psi(z) partial psi(z): $
$ overline(T)(overline(z)) = -frac(1,2) :overline(partial) psi(overline(z)) overline(partial) psi(overline(z)): $
The free fermion theory has a central charge of $c = 1/2$.


== The central charge
The central charge, initially introduced in the context of $T T$ correlation's anomaly part:
$ T(omega)T(z) = frac(c/2, (z-omega)^4) + frac(2T(omega),(z-omega)^2) + frac(T'(omega),z-omega) $

similarly the anti-holographic stress-energy tensor $overline(T)$ has the same form with $overline(c)$.

== Mode expansion and the Virasoro algebra
The Virasoro algebra can be viewed as the Laurent expansion of the stress-energy tensor $T(z)$ in terms of its modes $L_n$:
$ T(z) = sum_(n=-infinity)^infinity L_n z^(-n-2) $

A naive dimensional analysis of the OPE of $T(z)T(w)$ leads to the commutation relations of the Virasoro algebra:
$ [L_m, L_n] = (m-n)L_(m+n) + frac(c, 12) m(m^2-1) delta_(m+n,0) $

== In- and out-states
The most important part of Hilbert space construction is to define vacuum states, from which we can generate the entire Hilbert space by applying the raising operators. From the perspective of QFT and interaction picture, the vacuum state is the asymptotic state at $t -> -infinity$ and $t ->  +infinity$, where the influence of the interacting fields vanishes. They are called the in-states and out-states, respectively. In CFT, we can also define the in- and out-states as the highest-weight states of the Virasoro algebra.

The in-states are 
$ |0_(text(i n)) chevron.r $

In CFT, we have two types of vacuum states: the in-states and the out-states. The in-states are defined as the states that are annihilated by all positive modes $L_n$ with $n > 0$, while the out-states are defined as the states that are annihilated by all negative modes $L_n$ with $n < 0$. The in- and out-states are also called the highest-weight states of the Virasoro algebra

the in- and out-states. We will see that the in- and out-states are defined as the highest-weight states of the Virasoro algebra, which are annihilated by all positive modes $L_n$ with $n > 0$. The highest-weight states are also called primary states, and they correspond to primary fields in the CFT. The descendants of the primary states are generated by acting with the negative modes $L_{-n}$ on the primary states, and they correspond to descendant fields in the CFT.

== Highest-weight states


== Descendants fields


== Duality and the bootstrap