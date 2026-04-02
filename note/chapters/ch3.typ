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

$ delta_(epsilon) Phi(z) = -[Q_(epsilon), Phi(z)] $

where $Q_(epsilon)$ is the conformal charge associated with the infinitesimal conformal transformation $epsilon(z)$, defined as $Q_(epsilon) = frac(1, 2pi i)integral.cont d z epsilon T$. The Ward identities can be derived from the conservation of the stress-energy tensor and the definition of the primary fields. They can be used to compute the correlation functions of the primary fields, which are the building blocks of the CFT.

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

From above figure, we can see that the time translation $t arrow.r t+lambda$ along the cylinder's axis corresponds to the scale transformation $z arrow.r e^(2pi lambda / L) z$ on the complex plane. And the spatial translation $x arrow.r x + lambda$ along the cylinder corresponds to the rotation $z arrow.r e^(2pi i lambda / L) z$ on the complex plane. Thus, the generator of time translation on the cylinder, which is the energy operator Hamiltonian $H$, corresponds to the generator of scale transformation on the complex plane, which is the dilation operator $D$. Similarly, the generator of spatial translation on the cylinder, momentum operator $P$, corresponds to the generator of rotation on the complex plane $S$. Their spectrum also corresponds to each other. We could have below table for the correspondence between the generators and their spectrum:

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
  [dilation operator $D$],
  [Momentum operator $P$],
  [Rotation operator $S$],
  [Spectrum of $H$: energy $E_n$],
  [Spectrum of $D$: scaling dimension $Delta_n$],
  [Spectrum of $P$: momentum $k_n$],
  [Spectrum of $S$: conformal spin $s_n$],
)

The radial quantization allows us to compute the commutator in the form: $ [A, B] = integral.cont_0 d w integral.cont_w d z a(z) b(w)$, where $a(z)$ and $b(w)$ are $integral.cont a(z) d z$ and $integral.cont b(w) d w$, respectively. The contour integrals are taken around the origin and the point $w$, respectively. This formula allows us to translate the commutator of two operators into the correlation function of the corresponding fields, which can be computed using the Ward identities, and vice versa. 

=== Primary fields
The primary fields are the fields that transform covariantly under the conformal transformations. They are defined as the fields that satisfy the following transformation law under the conformal transformation $z arrow.r f(z)$:
$ phi(z) arrow.r (partial f(z))^h (partial overline(f)(overline(z)))^h overline(phi)(overline(z)) $
where $h$ and $overline(h)$ are the conformal weights of the primary field $phi(z, overline(z))$. The primary fields are the highest-weight states of the Virasoro algebra, which we will introduce in the next section. The correlation functions of the primary fields can be computed using the Ward identities, and they have a specific form determined by the conformal symmetry. So here we can also list a table for the different definition of primary fields:

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
  [$phi(z) arrow.r (partial f(z))^h (partial overline(f)(overline(z)))^overline(h) overline(phi)(overline(z))$],
  [Transformation under infinitesimal conformal transformation $z arrow.r z+ epsilon(z)$],
  [$delta_(epsilon) phi(z, overline(z)) = (h partial epsilon + epsilon partial + overline(h)overline(partial) overline(epsilon)+ overline(epsilon) overline(partial)) phi(z, overline(z))$],
  [Correlation with the stress-energy tensor],
  [$T(z) phi(w, overline(w)) = frac(h, (z-w)^2) phi(w, overline(w)) + frac(partial phi(w, overline(w)), z-w) + ... $],
  [Correlation functions with scaling dimension $Delta$ and conformal spin $s$],
  [$angle.l phi(z_1, overline(z)_1) phi(z_2, overline(z)_2) angle.r = frac(C,(z_1 - z_2)^(Delta + s) (overline(z)_1 - overline(z)_2)^(Delta - s))$],
  [Correlation under transformation],
  [$angle.l phi(z_1^(prime)) phi(z_2^(prime)) angle.r = (partial f(z))^h (partial overline(f)(overline(z)))^overline(h)  angle.l phi(z_1) phi(z_2) angle.r$],
)

== Outline of this chapter
- Virasoro algebra: $[L_m, L_n] = (m-n)L_(m+n) + frac(c, 12) m(m^2-1) delta_(m+n,0)$
- Primary fields and operator-state correspondence: $[L_n, phi(z)] = z^n (z partial + (n+1) h) phi(z)$
- Relation between the generators on the cylinder and complex plane: $H = frac(2pi, L)(L_0 + overline(L)_0 - frac(c, 12))$, $P = frac(2pi, L)(L_0 -  overline(L)_0)$
- Highest-weight states: $L_n |h> = 0$ for $n > 0$, $L_0 |h> = h |h>$

== The central charge
The central charge, initially introduced in the context of $T T$ correlation's anomaly part (this formula we will derive later in free boson and free fermion part):
$ T(omega)T(z) = frac(c/2, (z-omega)^4) + frac(2T(omega),(z-omega)^2) + frac(T'(omega),z-omega) $

similarly the anti-holographic stress-energy tensor $overline(T)$ has the same form with $overline(c)$, which means that the stress-energy tensor is not primary field, but a quasi-primary field with conformal weight $h=2$. From above we could observe that $angle.l T(z)T(0) angle.r=frac(c,2z^4)$, thus we expect $c>0$ in a theory with a positive semi-definite Hilbert space. The central charge can be viewed as a measure of the number of degrees of freedom in the theory, and it plays a crucial role in the classification of CFTs. For example, the minimal models have central charges that are rational numbers less than 1, while the free boson and free fermion theories have central charges of 1 and 1/2, respectively.

One interesting aspect we would like to study is how the stress-energy tensor transforms under conformal transformations. We could start from its infinitesimal change under conformal transformation, which is given by:
$ delta_(epsilon) T(z) = -[Q_(epsilon), T(z)] = frac(1, 2pi i)integral.cont (d z epsilon(z) R(T(z) T(omega)) \
= frac(1, 2pi i)integral.cont d z epsilon(z) [frac(c/2, (z-omega)^4) + frac(2T(omega),(z-omega)^2) + frac(T'(omega),z-omega)] = (2 partial epsilon + epsilon partial) T(z) + frac(c, 12) partial^3 epsilon $

Thus after integral, it gives

$ T(z) arrow.r T^(prime)(omega) = (partial f)^(-2) [T(z) - frac(c, 12) {f, z}] $

where ${f, z} = frac(f'''(z), f'(z)) - frac(3,2) (frac(f''(z),f'(z)))^2$ is the Schwarzian derivative. The transformation law of the stress-energy tensor under conformal transformations is different from that of primary fields, which indicates that the stress-energy tensor is not a primary field, but a quasi-primary field. 

We could give an illustration on its physical meaning of central charge $c$, For example, we compute the free energy/Casimir energy of a CFT on a cylinder with circumference $L$ with conformal map $z arrow.r omega = frac(L, 2pi)ln(z)$, thus the stress-energy tensor on cylinder is, where $T_(p l)(z)=0$: 
$ angle.l T_(c y l)(omega) angle.r = (frac(2pi, L))^2 [angle.l T(z) angle.r - frac(c, 24)] = -frac(c pi^2,6 L^2) $

== Mode expansion and the Virasoro algebra
Following the path we have dealt with Witt algebra, combined with *Ward identity, radial quantization*, we want to write down the corresponding infinitesimal change of field due to conformal transformation:

$ delta phi = -[Q, phi] = frac(1, 2pi i)integral.cont (d z epsilon(z) R(T(z) phi(omega, overline(omega) ))+ d overline(z) overline(epsilon)(overline(z))R(T(overline(z)) phi(omega, overline(omega) )))) $

the Virasoro algebra can be viewed as the Laurent expansion of the stress-energy tensor $T(z)$ in terms of its modes $L_n$:
$ T(z) = sum_(n=-infinity)^infinity L_n z^(-n-2), L_n = frac(1, 2pi i)integral.cont d z z^(n+1) T(z) $

similarly for $epsilon(z) = sum_n c_n z^(n+1)$. Then the conformal charge $Q_(epsilon) = frac(1, 2pi i)integral.cont d z epsilon(z) T(z) = sum_n c_n L_n$. Thus we can rewrite the infinitesimal change of field as:

$ delta phi = -[Q, phi] = sum_n c_n [L_n, phi] + overline(c)_n [overline(L)_n, phi] $


A complex analysis of the OPE of $T(z)T(w)$ leads to the commutation relations of the Virasoro algebra:
$ [L_m, L_n] = frac(1, (2pi i)^2)integral.cont_0 d z integral.cont_z d w z^(m+1) w^(n+1) {frac(c/2, (z-omega)^4) + frac(2T(omega),(z-omega)^2) + frac(T'(omega),z-omega)} =
\ (m-n)L_(m+n) + frac(c, 12) m(m^2-1) delta_(m+n,0) $

And importantly $[L_n, overline(L)_m ]=0$, that is, the holomorphic and anti-holomorphic sectors are decoupled.

Another important commutator is 
$ [L_n, phi(z)] = frac(1, 2pi i)integral.cont d w w^(n+1) {frac(h, (z-w)^2) phi(w) + frac(partial phi(w), z-w) + ...} = z^n (z partial + (n+1) h) phi $

Moreover if we expand the mode of primary field $phi(z) = sum_n phi_n z^(-n-h)$, we can also derive the commutation relation between the Virasoro generators and the primary fields:
$ [L_n, phi_m] = (n(h-1)-m) phi_(m+n) $

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
  = sum_n c_n [L_n, phi] + overline(c)_n [overline(L)_n, phi] $],
  [$delta phi = -epsilon(z) partial phi - overline(epsilon)(overline(z)) overline(partial) phi \
  = sum_n c_n l_n phi + overline(c)_n overline(l)_n phi$],
  [$angle.l T(z)T(0) angle.r = frac(c, 2(z-0)^4)$],
  [$angle.l T(z)T(0) angle.r = 0$],
  [With central charge $c$ (chiral anomaly)],
  [No central charge],
)
where the classical generators of conformal transformations $l_n = -z^(n+1) partial $. Among them the global conformal transformations generated by $l_(-1), l_0, l_1$, corresponds to the translation, dilation ($l_0 + overline(l)_0$)+rotation ($i(l_0 - overline(l)_0)$), and special conformal transformation, respectively.

their quantum counterparts $L_(-1), L_0, L_1$ still satisfies 
$ [L_(minus.plus 1), L_(0)] = minus.plus L_(minus.plus 1), [L_(1), L_(-1)] = 2L_0 $  
thus also generate the global conformal transformations, and could be related to Hamiltonian and momentum operators on the cylinder (we will prove it later, but this makes sense intuitively).

$ H = frac(2pi, L)(L_0 + overline(L)_0 - frac(c, 12)) \
P = frac(2pi, L)(L_0 -  overline(L)_0) $

== In- and out-states
The most important part of Hilbert space construction is to define vacuum states, from which we can generate the entire Hilbert space by applying the raising operators. From the perspective of QFT and interaction picture, the system have different ground states. A natural choice for the vacuum state is the asymptotic state at $t -> -infinity$ and $t ->  +infinity$, where the influence of the interacting fields vanishes. They are called the in-states and out-states, respectively. In CFT, we can also define the in- and out-states as the highest-weight states of the Virasoro algebra.

The in-states are 
$ |phi_(text(i n)) angle.r  = lim_(z, overline(z) arrow.r 0) phi(z, overline(z) ) |0 angle.r $

As for the out-states, we can define them as the states at $z, overline(z) arrow.r infinity$, which can be obtained by applying the conformal transformation $omega = 1/z$ to the in-states:
$ |phi_(text(o u t)) angle.r  = lim_(omega, overline(omega) arrow.r 0) phi(omega, overline(omega) ) |0 angle.r = lim_(z, overline(z) arrow.r 0) frac(1, z^(2h)) frac(1, overline(z)^(2h)) phi(1/z, 1/overline(z) ) |0 angle.r  $

In similarity, for the stress-energy tensor, we can also use their properties to prove a key result by taking the hermitian conjugate of the mode expansion of $T(z)$, and substituting $z$ with $1/overline(z)$ in $T(z)$, we have:
$ T^(dagger)(z)=sum frac(L^(dagger)_m, overline(z)^(m+2)), T(frac(1,overline(z)))frac(1, overline(z)^4) = sum frac(L_m, overline(z)^(-m-2))frac(1, overline(z)^4) , $
which leads to $ L^(dagger)_m = L_(-m) . $ 

In CFT, we have two types of vacuum states: the in-states and the out-states. The in-states are defined as the states that are annihilated by all positive modes $L_n$ with $n > 0$, while the out-states are defined as the states that are annihilated by all negative modes $L_n$ with $n < 0$. The in- and out-states are also called the highest-weight states of the Virasoro algebra

We will see that the in- and out-states are defined as the highest-weight states of the Virasoro algebra, which are annihilated by all positive modes $L_n$ with $n > 0$. The highest-weight states are also called primary states, and they correspond to primary fields in the CFT. The descendants of the primary states are generated by acting with the negative modes $L_(-n)$ on the primary states, and they correspond to descendant fields in the CFT.



== Highest-weight states
The vacuum state $|0 angle.r$ must be invariant under the global conformal transformations generated by $L_(-1), L_0, L_1$, which means that it must satisfy the following conditions:
$ L_(-1) |0 angle.r = L_0 |0 angle.r = L_1 |0 angle.r = 0 . $

These could also seen from the regularity of the mode expansion of stress-energy tensor $T(z) |0 angle.r= sum_m frac(L_m, z^(m+2))|0 angle.r$ at $z=0$, which requires that $L_n |0 angle.r = 0$ for $n >= -1$.

Thus for the asymptotic in-states 
$ |h, overline(h) angle.r = phi(0, 0)|0 angle.r $


We could utilize the commutation relations $[L_n, phi] = h(n+1)omega^n phi + omega^(n+1)partial phi$, thus:
$ L_0|h,overline(h) angle.r = L_0 phi(0,0)|h, overline(h) angle.r = (phi(0,0) L_0 + h)|h, overline(h) angle.r = h|h, overline(h) angle.r, \
 overline(L)_0|h,overline(h) angle.r = overline(h)|h, overline(h) angle.r $
== Descendants fields

Thus by applying the negative modes $L_(-n)$ on the primary states, we can generate the descendant states, which have conformal weights that are greater than the conformal weight of the primary state. The descendant fields correspond to the descendant states in the Hilbert space, and they can be obtained by applying the Virasoro generators to the primary fields. They have conformal weights that raise by integers compared to the primary fields
$ L_(-n)|h, overline(h) angle.r = L_(-n)L_0|h, overline(h) angle.r = (L_0L_(-n)+n L_(-n))|h, overline(h) angle.r = (h+n)|h, overline(h) angle.r $

And we could review the $T phi$ correlation from the perspective of descendant fields, which is given by:
$ T(z) phi(w, overline(w)) = sum_n frac(L_n phi(w, overline(w)), (z-w)^(n+2)) = frac(1, (z-w)^2) L_0 phi + frac(1, z-w) L_(-1) phi + L_2 phi + (z-omega) L_(-3) phi+ ...
\ = frac(h, (z-w)^2) phi(w, overline(w)) + frac(partial phi(w, overline(w)), z-w) + ... $

From which we could identify:
$ L_0 phi = h phi, L_(-1) phi = partial phi , $
and a simple descendant field is 
$ L_(-2) 1 = integral.cont frac(1, 2pi i)d z frac(1, (z-w)) T(z) = T(omega) .$

Thus the stress-energy tensor itself can be viewed as a descendant field of the identity operator, with conformal weight $h=2$.

== The structure of the Hilbert space
The Hilbert space of a CFT can be constructed by starting from the highest-weight states (primary states) and applying the negative modes of the Virasoro algebra to generate the descendant states. The highest-weight states are annihilated by all positive modes $L_n$ with $n > 0$, and they are eigenstates of $L_0$ with eigenvalue $h$, which is the conformal weight of the corresponding primary field. The descendant states are generated by acting with the negative modes $L_(-n)$ on the highest-weight states, and they have conformal weights that are greater than the conformal weight of the primary state. The structure of the Hilbert space can be visualized as a tower of states, where the primary state is at the bottom and the descendant states are above it, with increasing conformal weights.

The subset of full Hilbert space generated by a primary state $|h, angle.r$ and its descendants is called a conformal tower, which is closed under the action of the Virasoro algebra. Thus they forms a representation of the Virasoro algebra. The full Hilbert space of the CFT can be decomposed into a direct sum of conformal towers, each corresponding to a different primary state. Each tower is called a Verma module.

For $n>0$, the states generated by $L_(-n)$ are called the level-$n$ descendants of the primary state. We could list a table for the first few levels of descendants:

#table(
  columns: 3,
  align: (left, left, left),
  stroke: 0.6pt,
  inset: 6pt,
  table.header(
    [*Level*],
    [*Conformal weight*],
    [*State*],
  ),
  [0],
  [$h$],
  [$|h angle.r$],
  [1],
  [$h + 1$],
  [$L_(-1) |h angle.r$],
  [2],
  [$h + 2$], 
  [$L_(-2) |h angle.r$, $L_(-1)^2 |h angle.r$],
  [3],
  [$h+3$],
  [$L_(-3) |h angle.r$, $L_(-1)L_(-2) |h angle.r$, $L_(-1)^3 |h angle.r$],
  [],
  [$dots$],
  [],
  [$N$],
  [$h + N$],
  [$P(N)$ fields],
)


== Example: Ising spin field $sigma$

In the Ising CFT ($c = 1\/2$), totally three primary field: identify field $ 1$, the spin field $sigma$ and the energy field $epsilon$, with conformal weights separately given by $h_1 = 0$, $h_sigma = frac(1, 16)$ and $h_epsilon = frac(1, 2)$. Thus for the spin field $sigma$, we have:
$ h_1 = overline(h)_1 = 0,  quad Delta_1 = 0 
\ h_sigma = overline(h)_sigma = frac(1, 16), quad Delta_sigma = h_sigma + overline(h)_sigma = frac(1, 8)
\ h_epsilon = overline(h)_epsilon = frac(1, 2), quad Delta_epsilon = h_epsilon + overline(h)_epsilon = 1 $

=== Primary state (highest-weight state)

The primary state $|sigma angle.r equiv sigma(0,0) |0 angle.r$ satisfies the highest-weight conditions:
$ L_n |sigma angle.r &= 0 quad "for" n = 1, 2, 3, dots $
$ L_0 |sigma angle.r &= frac(1, 16) |sigma angle.r, overline(L)_0 |sigma angle.r &= frac(1, 16) |sigma angle.r $

=== Construction of descendant states

Applying the raising operators $L_(-n)$ (with $n > 0$) to $|sigma angle.r$ generates descendant states:

*Level-1 descendant* ($L_(-1)$ action):
$ |partial sigma angle.r equiv L_(-1) |sigma angle.r, quad L_0 |partial sigma angle.r = (frac(1, 16) + 1) |partial sigma angle.r = frac(17, 16) |partial sigma angle.r $
This corresponds to the field $partial_z sigma(z, overline(z))$ with scaling dimension $Delta = 17\/8$.

*Level-2 descendants*:
$ |sigma^((2)) angle.r &equiv L_(-2) |sigma angle.r, quad h = frac(1, 16) + 2 = frac(33, 16) $
$ |partial^2 sigma angle.r &equiv L_(-1)^2 |sigma angle.r, quad h = frac(1, 16) + 2 = frac(33, 16) $

Note that at level 2, there are two states, which are not orthogonal. Using the Virasoro algebra relation, one finds:
$ angle.l sigma| L_2 L_(-1)^2 |sigma angle.r = angle.l sigma| (L_(-1)L_2 + 3 L_1 )L_(-1)|sigma angle.r = 3 angle.l sigma| L_1 L_(-1)|sigma angle.r = 3/8 $
Eventually, one constructs the full Verma module by including all possible products of $L_(-n)$ operators.

=== Specific matrix elements

For the descendant state $L_(-m) |sigma angle.r$:
$ L_0 (L_(-m) |sigma angle.r) = (frac(1, 16) + m) (L_(-m) |sigma angle.r) $

Action of lowering operators (example: $L_2$ acting on $L_(-2) |sigma angle.r$):
$ L_2 L_(-2) |sigma angle.r &= [L_2, L_(-2)] |sigma angle.r + L_(-2) L_2 |sigma angle.r \
&= (4 L_0 + frac(c, 12) dot 2 dot (4-1)) |sigma angle.r \
&= (4 dot frac(1, 16) + frac(1\/2, 12) dot 6) |sigma angle.r \
&= (frac(1, 4) + frac(1, 4)) |sigma angle.r = frac(1, 2) |sigma angle.r $

Norms and inner products can be computed similarly. For instance:
$ angle.l sigma | L_2 L_(-2) | sigma angle.r = frac(1, 2) angle.l sigma | sigma angle.r $

=== Null states in Ising CFT

In some cases, certain linear combinations of descendant states can vanish, leading to null states. For the Ising CFT, the null state at level 1/2 for the three primary state is given by:
$ L_(-1)^2 |1 angle.r = 0 \
(L_(-2) - frac(4, 3) L_(-1)^2) |sigma angle.r = 0 \
(L_(-2) - frac(3, 4) L_(-1)^2) |epsilon angle.r = 0 $
This null state indicates that the Verma module generated by $|epsilon angle.r$ is reducible, and the null state must be factored out to obtain the irreducible representation of the Virasoro algebra. This is a key feature of minimal models, that each primary field has null fields. And the presence of null states leads to a finite number of primary fields and a closed operator algebra.

#figure(
  image("./figs/Ising_spectrum.png", width: 80%),
  caption: [Exact spectrum of the Ising CFT Hamiltonian
in terms of $Delta$ and $s$, color-coded by conformal tower, showing the location of the primary states $|I angle.r$, $|sigma angle.r$and $|epsilon angle.r$, and the energy-momentum states $|T angle.r$and $ | overline(T) angle.r$. Due to null state, the state $L_(-1)|I angle.r $ is absent and at level-2 of $|sigma angle.r, |epsilon angle.r$ only single state is plotted. Note: We shift points horizontally from their allowed values (S is quantized) to avoid overlaps and better show degeneracies in this and subsequent figures.],
) <Ising_spectrum>



#figure(
  image("./figs/ladder_operation.png", width: 80%),
  caption: [Illustration of the action of the ladder operators (Virasoro generators) on the energy eigenstates of the Ising CFT Hamiltonian belonging to the $I$ conformal tower. Two possible paths from ($Delta = 4,S= 0$) to ($Delta = 4,S=−4$) are shown, as is the annihilation of the quasiprimary state $| Delta = 4,S= 0 angle.r$ by $overline(L)_(+1)$ and $L_(+1)$.],
) <ladder_operation>
=


== Duality and the bootstrap