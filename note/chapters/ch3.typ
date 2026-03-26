#import "@preview/cetz:0.3.4": canvas, draw

#set math.equation(numbering: "(3.1)")

= The central charge and the Virasoro algebra

In this chapter, our goal is to construct the Hilbert space in CFT. we will introduce the Virasoro algebra, which is a central extension of the Witt algebra, also the building block of Hilbert space. The Virasoro algebra plays a crucial role in two-dimensional conformal field theories (CFTs) and string theory. We will also discuss the concept of the central charge, which can be used to distinguish different CFTs.

== Review of chapter 2
From now on and later, we only focus on two-dimensional CFTs. In chapter 2, we introduced the stress-energy tensor, its properties, Ward identities, radial quantization, and definition of primary field. 

=== The stress-energy tensor
In 2D CFT, we have stress-energy tensor $T(z)$ and $overline(T)(overline(z))$, which are holomorphic and anti-holomorphic, respectively. They satisfy the following properties:
- $"Traceless:" T_(z overline(z)) = T_(overline(z) z) =0$
- $"Symmetric:" T_(mu nu) = T_(nu mu) $

And combined with the conservation law $partial^mu T_(mu nu) = 0$, we can derive that $T(z)$ is holomorphic and $overline(T)(overline(z))$ is anti-holomorphic $partial_(overline(z)) T_(z z) = partial_(z) T_(overline(z) overline(z)) = 0 $. Thus we could write $T(z) = T_(z z)$ and $overline(T)(overline(z)) = T_(overline(z) overline(z))$.

=== Ward identities
The Ward identities are the consequences of the symmetries of the theory, which can be derived from the conservation of the stress-energy tensor. They relate the correlation functions of the stress-energy tensor with the correlation functions of the primary fields. The Ward identities can be used to compute the correlation functions of the primary fields, which are the building blocks of the CFT.

$ delta_(epsilon) Phi(z) = [Q_(epsilon), Phi(z)] $

where $Q_(epsilon)$ is the conformal charge associated with the infinitesimal conformal transformation $epsilon(z)$. The Ward identities can be derived from the conservation of the stress-energy tensor and the definition of the primary fields. They can be used to compute the correlation functions of the primary fields, which are the building blocks of the CFT.

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

=== Primary fields
The primary fields are the fields that transform covariantly under the conformal transformations. They are defined as the fields that satisfy the following transformation law under the conformal transformation $z arrow.r f(z)$:
$ phi(z) arrow.r (partial f(z))^h (partial overline(f)(overline(z)))^h overline(phi)(overline(z)) $
where $h$ and $overline(h)$ are the conformal weights of the primary field $phi(z, overline(z))$. The primary fields are the highest-weight states of the Virasoro algebra, which we will introduce in the next section. The correlation functions of the primary fields can be computed using the Ward identities, and they have a specific form determined by the conformal symmetry.

So here we can also list a table for the different definition of primary fields:

#table(
  columns: 2,
  align: (left, left),
  stroke: 0.6pt,
  inset: 6pt,
  table.header(
    [*Definition*],
    [*Description*],
  ),
  [Transformation law under conformal transformation],
  [$phi(z) arrow.r (partial f(z))^h (partial overline(f)(overline(z)))^h overline(phi)(overline(z))$],
  [Transformation under infinitesimal conformal transformation $z arrow.r z+ epsilon(z)$],
  [$delta_(epsilon) phi(z, overline(z)) = (h partial epsilon + epsilon partial + overline(h)overline(partial) overline(epsilon)+ overline(epsilon) overline(partial)) phi(z, overline(z))$],
  [Correlation with the stress-energy tensor],
  [$T(z) phi(w, overline(w)) = frac(h, (z-w)^2) phi(w, overline(w)) + frac(partial phi(w, overline(w)), z-w) + ... $],
  [Correlation functions with scaling dimension $Delta$ and conformal spin $s$],
  [$angle.l (z_1, overline(z)_1) phi(z_2, overline(z)_2) angle.r = frac(C,(z_1 - z_2)^(Delta + s) (overline(z)_1 - overline(z)_2)^(Delta - s))$],
  [Highest-weight states of the Virasoro algebra (operator-state correspondence)],
  [$L_n |h> = 0$ for $n > 0$, $L_0 |h> = h |h>$],
)

== Outline of this chapter
- Virasoro algebra: $[L_m, L_n] = (m-n)L_(m+n) + frac(c, 12) m(m^2-1) delta_(m+n,0)$
- Primary fields and operator-state correspondence: $[L_n, phi(z)] = z^n (z partial + (n+1) h) phi(z)$
- Relation between the generators on the cylinder and complex plane: $H = frac(2pi, L)(L_0 + overline(L)_0 - frac(c, 12))$, $P = frac(2pi, L)(L_0 -  overline(L)_0)$
- Highest-weight states: $L_n |h> = 0$ for $n > 0$, $L_0 |h> = h |h>$
- Descendant fields: $[L_n, partial^k phi(z)] = z^n (z partial + (n+1) (h+k)) partial^k phi(z)$

== The central charge
The central charge, initially introduced in the context of $T T$ correlation's anomaly part:
$ T(omega)T(z) = frac(c/2, (z-omega)^4) + frac(2T(omega),(z-omega)^2) + frac(T'(omega),z-omega) $

similarly the anti-holographic stress-energy tensor $overline(T)$ has the same form with $overline(c)$.

== Mode expansion and the Virasoro algebra
The Virasoro algebra can be viewed as the Laurent expansion of the stress-energy tensor $T(z)$ in terms of its modes $L_n$:
$ T(z) = sum_(n=-infinity)^infinity L_n z^(-n-2) $

A naive dimensional analysis of the OPE of $T(z)T(w)$ leads to the commutation relations of the Virasoro algebra:
$ [L_m, L_n] = (m-n)L_(m+n) + frac(c, 12) m(m^2-1) delta_(m+n,0) $

We could compare the Virasoro algebra with the Witt algebra, which is the algebra of the generators of conformal transformations without the central extension in below table:

#table(
  columns: 2,
  align: (left, left),
  stroke: 0.6pt,
  inset: 6pt,
  table.header(
    [*Virasoro algebra*],
    [*Witt algebra*],
  ),
  [$[L_m, L_n] = (m-n)L_(m+n) + frac(c, 12) m(m^2-1) delta_(m+n,0)$],
  [$[l_m, l_n] = (m-n)l_(m+n)$],
  [$delta phi = frac(1, 2pi i)integral.cont (d z epsilon(z) R(T(z) phi(omega, overline(omega) ))+ d overline(z) overline(epsilon)(overline(z))R(T(overline(z)) phi(omega, overline(omega) )))) \
  approx sum_n c_n [L_n, phi] + overline(c)_n [overline(L)_n, phi] $],
  [$delta phi = -epsilon(z) partial phi - overline(epsilon)(overline(z)) overline(partial) phi \
  = sum_n c_n l_n phi + overline(c)_n overline(l)_n phi$],
  [With central charge $c$ (chiral anomaly)],
  [No central charge],
)
where the classical generators of conformal transformations $l_n = -z^(n+1) partial $. Among them the global conformal transformations generated by $l_{-1}, l_0, l_1$, corresponds to the translation, dilatation ($l_0 + overline(l)_0$)+rotation ($i(l_0 - overline(l)_0)$), and special conformal transformation, respectively.

Thus, their quantum counterparts $L_(-1), L_0, L_1$ also generate the global conformal transformations, and could be related to Hamiltonian and momentum operators on the cylinder.

$ H = frac(2pi, L)(L_0 + overline(L)_0 - frac(c, 12)) \
P = frac(2pi, L)(L_0 -  overline(L)_0) $

== In- and out-states
The most important part of Hilbert space construction is to define vacuum states, from which we can generate the entire Hilbert space by applying the raising operators. From the perspective of QFT and interaction picture, the vacuum state is the asymptotic state at $t -> -infinity$ and $t ->  +infinity$, where the influence of the interacting fields vanishes. They are called the in-states and out-states, respectively. In CFT, we can also define the in- and out-states as the highest-weight states of the Virasoro algebra.

The in-states are 
$ |phi_(text(i n)) angle.r  = lim_(z, overline(z) arrow.r 0) phi(z, overline(z) ) |0 angle.r$

As for the out-states, we can define them as the states at $z, overline(z) arrow.r infinity$, which can be obtained by applying the conformal transformation $z arrow.r 1/z$ to the in-states:
$ |phi_(text(o u t)) angle.r  = lim_(z, overline(z) arrow.r infinity) phi(z, overline(z) ) |0 angle.r = lim_(z, overline(z) arrow.r 0) phi(1/z, 1/overline(z) ) |0 angle.r$


In CFT, we have two types of vacuum states: the in-states and the out-states. The in-states are defined as the states that are annihilated by all positive modes $L_n$ with $n > 0$, while the out-states are defined as the states that are annihilated by all negative modes $L_n$ with $n < 0$. The in- and out-states are also called the highest-weight states of the Virasoro algebra

the in- and out-states. We will see that the in- and out-states are defined as the highest-weight states of the Virasoro algebra, which are annihilated by all positive modes $L_n$ with $n > 0$. The highest-weight states are also called primary states, and they correspond to primary fields in the CFT. The descendants of the primary states are generated by acting with the negative modes $L_{-n}$ on the primary states, and they correspond to descendant fields in the CFT.

== Highest-weight states
The vacuum state $|0 angle.r$ must be invariant under the global conformal transformations generated by $L_(-1), L_0, L_1$, which means that it must satisfy the following conditions:
$ L_{-1} |0 angle.r = L_0 |0 angle.r = L_1 |0 angle.r = 0 $

Thus the asymptotic in-states 
$
|h, overline(h) angle.r = phi(0, 0)|0 angle.r $

We conclude that 
$ L_0|h,overline(h) angle.r = h|h, overline(h) angle.r,  overline(L)_0|h,overline(h) angle.r = overline(h)|h, overline(h) angle.r $
== Descendants fields

Thus by applying the negative modes $L_{-n}$ on the primary states, we can generate the descendant states, which have conformal weights that are greater than the conformal weight of the primary state. The descendant fields correspond to the descendant states in the Hilbert space, and they can be obtained by applying the Virasoro generators to the primary fields.
== The structure of the Hilbert space
The Hilbert space of a CFT can be constructed by starting from the highest-weight states (primary states) and applying the negative modes of the Virasoro algebra to generate the descendant states. The highest-weight states are annihilated by all positive modes $L_n$ with $n > 0$, and they are eigenstates of $L_0$ with eigenvalue $h$, which is the conformal weight of the corresponding primary field. The descendant states are generated by acting with the negative modes $L_(-n)$ on the highest-weight states, and they have conformal weights that are greater than the conformal weight of the primary state. The structure of the Hilbert space can be visualized as a tower of states, where the primary state is at the bottom and the descendant states are above it, with increasing conformal weights.

The subset of full Hilbert space generated by a primary state $|h, angle.r$ and its descendants is called a conformal tower, which is closed under the action of the Virasoro algebra. Thus they forms a representation of the Virasoro algebra. The full Hilbert space of the CFT can be decomposed into a direct sum of conformal towers, each corresponding to a different primary state. Each tower is called a Verma module.

#figure(
  image("./figs/Ising_spectrum.png", width: 80%),
  caption: [Exact spectrum of the Ising CFT Hamiltonian
in terms of $Delta$ and $s$, color-coded by conformal tower, showing the location of the primary states $|I angle.r$, $|sigma angle.r$and $|epsilon angle.r$, and the energy-momentum states $|T angle.r$and $ | overline(T) angle.r$. Note: We shift points horizontally from their allowed values (S is quantized) to avoid overlaps and better show degeneracies in this and subsequent figures.],
) <Ising_spectrum>



#figure(
  image("./figs/ladder_operation.png", width: 80%),
  caption: [Illustration of the action of the ladder operators (Virasoro generators) on the energy eigenstates of the Ising CFT Hamiltonian belonging to the $I$ conformal tower. Two possible paths from ($Delta = 4,S= 0$) to ($Delta = 4,S=−4$) are shown, as is the annihilation of the quasiprimary state $| Delta = 4,S= 0 angle.r$ by $overline(L)_(+1)$ and $L_(+1)$.],
) <ladder_operation>

== Duality and the bootstrap

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

