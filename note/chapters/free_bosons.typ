
== The free bosons

Here we review the basic properties of free bosons, which are the simplest example of CFTs with central charge $c = 1$. The free boson theory is described by a scalar field $X(z, overline(z))$ with the action:
$ S = frac(1,4pi) integral d^2z partial X overline(partial) X $

=== The boson propagator

The equation of motion is $partial overline(partial) X = 0$, which means $X$ can be decomposed into holomorphic and anti-holomorphic parts. The two-point function (propagator) is:
$ angle.l X(z, overline(z)) X(w, overline(w)) angle.r = -frac(1, 2) ln |z-w|^2 = -frac(1,2) ln(z-w) - frac(1,2) ln(overline(z) - overline(w)) $

Taking derivatives, we obtain:
$ angle.l partial X(z) partial X(w) angle.r = -frac(1, (z-w)^2) $
$ angle.l overline(partial) X(overline(z)) overline(partial) X(overline(w)) angle.r = -frac(1, (overline(z) - overline(w))^2) $
$ angle.l partial X(z) overline(partial) X(overline(w)) angle.r = 0 $

Thus $partial X(z)$ is a holomorphic field with conformal weight $(h, overline(h)) = (1, 0)$.

=== The stress-energy tensor

The stress-energy tensor is derived from the action using the Noether procedure:
$ T(z) = -frac(1,2) :partial X(z) partial X(z): $
$ overline(T)(overline(z)) = -frac(1,2) :overline(partial) X(overline(z)) overline(partial) X(overline(z)): $

The normal ordering removes the self-contraction singularity:
$ :partial X(z) partial X(z): = lim_(w -> z) (partial X(z) partial X(w) - angle.l partial X(z) partial X(w) angle.r) $

=== The $T (partial X)$ OPE

We derive the OPE of $T(z)$ with $partial X(w)$. Using Wick's theorem:

$ T(z) partial X(w) &= -frac(1,2) :partial X(z) partial X(z): partial X(w) $

Contracting $partial X(w)$ with the fields inside the normal ordering:
$ T(z) partial X(w) &= -frac(1,2) (angle.l partial X(z) partial X(w) angle.r partial X(z) + partial X(z) angle.l partial X(z) partial X(w) angle.r) + "regular" \
&= -frac(1,2) dot 2 dot (-frac(1, (z-w)^2)) partial X(z) + "regular" \
&= frac(partial X(z), (z-w)^2) + "regular" $

Expanding $partial X(z)$ around $w$:
$ partial X(z) = partial X(w) + (z-w) partial^2 X(w) + dots $

We get:
$ T(z) partial X(w) = frac(partial X(w), (z-w)^2) + frac(partial^2 X(w), z-w) + "regular" $

This confirms that $partial X$ is a primary field with conformal weight $h = 1$.

=== The $T T$ OPE and central charge

Now we compute the $T(z) T(w)$ OPE:
$ T(z) T(w) = frac(1,4) :partial X(z) partial X(z): :partial X(w) partial X(w): $

Using Wick's theorem for products of normal-ordered operators:

*Double contractions* (most singular term):
$ frac(1,4) dot 2 dot angle.l partial X(z) partial X(w) angle.r^2 = frac(1,4) dot 2 dot frac(1, (z-w)^4) = frac(1\/2, (z-w)^4) $

This gives $c\/2 = 1\/2$, so $c = 1$.

*Single contractions* (next order):
$ frac(1,4) dot 4 dot angle.l partial X(z) partial X(w) angle.r :partial X(z) partial X(w): = -frac(1, (z-w)^2) :partial X(z) partial X(w): $

Expanding around $w$:
$ :partial X(z) partial X(w): = :partial X(w) partial X(w): + (z-w) :partial^2 X(w) partial X(w): + dots $

Note that $:partial X(w) partial X(w): = -2 T(w)$, so:
$ -frac(1, (z-w)^2) (-2 T(w) + (z-w)(-2 partial T(w)) + dots) = frac(2 T(w), (z-w)^2) + frac(partial T(w), z-w) + dots $

The final result is:
$ T(z) T(w) = frac(c\/2, (z-w)^4) + frac(2 T(w), (z-w)^2) + frac(partial T(w), z-w) + "regular" $
with $c = 1$.

=== Summary: OPEs of the free boson theory

#table(
  columns: 2,
  align: (left, left),
  stroke: 0.6pt,
  inset: 8pt,
  table.header(
    [*OPE*],
    [*Result*],
  ),
  [$partial X(z) partial X(w)$],
  [$display(-frac(1, (z-w)^2)) + "regular"$],
  [$T(z) partial X(w)$],
  [$display(frac(partial X(w), (z-w)^2) + frac(partial^2 X(w), z-w)) + "regular"$],
  [$T(z) T(w)$],
  [$display(frac(1\/2, (z-w)^4) + frac(2 T(w), (z-w)^2) + frac(partial T(w), z-w)) + "regular"$],
)

=== Mode expansion

The free boson field $X(z, overline(z))$ has the mode expansion:
$ X(z, overline(z)) = x_0 - i p_0 ln(z overline(z)) + i sum_(n != 0) frac(1, n) (alpha_n z^(-n) + overline(alpha)_n overline(z)^(-n)) $

where $x_0$ is the zero-mode position, $p_0$ is the momentum, and $alpha_n, overline(alpha)_n$ are the oscillator modes. The commutation relations are:
$ [x_0, p_0] = i, quad [alpha_m, alpha_n] = m delta_(m+n, 0), quad [overline(alpha)_m, overline(alpha)_n] = m delta_(m+n, 0) $

The Virasoro generators in terms of oscillator modes:
$ L_n = frac(1,2) sum_(m in ZZ) :alpha_(n-m) alpha_m: $
$ L_0 = frac(1,2) alpha_0^2 + sum_(m > 0) alpha_(-m) alpha_m $

where $alpha_0 = p_0$ is the momentum zero mode.

== Boundary conditions and compactification

=== Periodic boundary conditions (PBC)

Consider the free boson on a cylinder with circumference $L$ (spatial direction) and the field satisfying periodic boundary conditions:
$ X(sigma + L, tau) = X(sigma, tau) $

In the complex coordinate $z = e^(2pi(tau + i sigma)\/L)$, this is automatically satisfied since $z$ is single-valued. The mode expansion becomes:
$ X(z, overline(z)) = x_0 - i frac(p_0 L, 2pi) ln(z overline(z)) + i sum_(n != 0) frac(1, n) (alpha_n z^(-n) + overline(alpha)_n overline(z)^(-n)) $

The momentum is quantized: for a non-compact boson, $p_0$ is continuous. The Hamiltonian and momentum are:
$ H = frac(2pi, L) (L_0 + overline(L)_0 - frac(c, 12)) = frac(2pi, L) (frac(p_0^2, 2) + N + overline(N) - frac(1, 12)) $
$ P = frac(2pi, L) (L_0 - overline(L)_0) = frac(2pi, L) (N - overline(N)) $

where $N = sum_(n>0) alpha_(-n) alpha_n$ and $overline(N) = sum_(n>0) overline(alpha)_(-n) overline(alpha)_n$ are the level numbers.

=== Compactification on a circle

Now consider the boson taking values on a circle of radius $R$:
$ X tilde.eq X + 2pi R $

This identification has two important consequences:

*1. Momentum quantization:* The wavefunction $e^(i p_0 X)$ must be single-valued under $X -> X + 2pi R$, requiring:
$ p_0 = frac(n, R), quad n in ZZ $

*2. Winding sectors:* The field can wind around the target circle:
$ X(sigma + L, tau) = X(sigma, tau) + 2pi R w, quad w in ZZ $

where $w$ is the winding number. The mode expansion becomes:
$ X(z, overline(z)) = x_0 - i (frac(n, R) + frac(w R, 2)) ln z - i (frac(n, R) - frac(w R, 2)) ln overline(z) + "oscillators" $

We define the left and right momenta:
$ p_L = frac(n, R) + frac(w R, 2), quad p_R = frac(n, R) - frac(w R, 2) $

The conformal weights of the vertex operator $e^(i p_L X_L + i p_R X_R)$ are:
$ h = frac(p_L^2, 2) = frac(1,2) (frac(n, R) + frac(w R, 2))^2 $
$ overline(h) = frac(p_R^2, 2) = frac(1,2) (frac(n, R) - frac(w R, 2))^2 $

The scaling dimension and spin are:
$ Delta = h + overline(h) = frac(n^2, R^2) + frac(w^2 R^2, 4) $
$ s = h - overline(h) = n w $

#figure(
  table(
    columns: 4,
    align: (center, center, center, center),
    stroke: 0.6pt,
    inset: 6pt,
    table.header([$n$], [$w$], [$Delta$], [$s$]),
    [$0$], [$0$], [$0$], [$0$],
    [$plus.minus 1$], [$0$], [$1\/R^2$], [$0$],
    [$0$], [$plus.minus 1$], [$R^2\/4$], [$0$],
    [$plus.minus 1$], [$plus.minus 1$], [$1\/R^2 + R^2\/4$], [$plus.minus 1$],
  ),
  caption: [Low-lying states in the compactified boson theory (oscillator excitations omitted). The spectrum depends on the compactification radius $R$.]
)

=== T-duality

The compactified boson has a remarkable symmetry called *T-duality*: the theory at radius $R$ is equivalent to the theory at radius $2\/R$ (in units where $alpha' = 2$), with the exchange:
$ n <-> w, quad R <-> frac(2, R) $

This can be seen from the spectrum: under $R -> 2\/R$, we have:
$ frac(n, R) -> frac(n R, 2), quad frac(w R, 2) -> frac(w, R) $

which is equivalent to swapping $n$ and $w$. The self-dual radius is $R = sqrt(2)$.

=== Special radii

At certain radii, the theory has enhanced symmetry:

- *$R = sqrt(2)$ (self-dual radius):* The theory has enhanced $S U(2)_1 times S U(2)_1$ symmetry. Additional marginal operators $(partial X)^2$, $e^(plus.minus i sqrt(2) X)$ become dimension $(1,0)$.

- *$R = 1$ (fermionization radius):* The compactified boson is equivalent to a free Dirac fermion. The vertex operators $e^(plus.minus i X)$ have dimension $(1\/2, 0)$ and can be identified with fermion fields.

- *$R -> infinity$ (decompactification):* The winding states become infinitely massive and decouple, leaving a non-compact boson.

- *$R -> 0$:* By T-duality, this is equivalent to $R -> infinity$ with momentum and winding exchanged.

== $ZZ_2$ Orbifold

=== Construction

The $ZZ_2$ orbifold is constructed by gauging the symmetry $X -> -X$. This projection:

1. *Keeps only invariant states* from the untwisted sector (states with even winding/momentum)
2. *Adds a twisted sector* with fields satisfying anti-periodic boundary conditions

In the *untwisted sector*, we keep states invariant under $X -> -X$:
- The oscillators transform as $alpha_n -> -alpha_n$
- States must have even total oscillator number
- Vertex operators $e^(i p X)$ are projected to $cos(p X)$ and $sin(p X)$

In the *twisted sector*, the field satisfies:
$ X(sigma + L) = -X(sigma) $

This means the field has a branch cut, and the mode expansion changes to half-integer modes:
$ X(z) = i sum_(r in ZZ + 1\/2) frac(alpha_r, r) z^(-r) $

The twisted sector ground state has conformal weight:
$ h_"twist" = frac(1, 16) $

This is the same as the Ising spin field $sigma$!

=== Partition function

The orbifold partition function includes four contributions:

$ Z_"orbifold" = frac(1,2) (Z_(U U) + Z_(U T) + Z_(T U) + Z_(T T)) $

where:
- $Z_(U U)$: Untwisted sector, untwisted boundary conditions
- $Z_(U T)$: Untwisted sector, twisted (by $g$) in time direction  
- $Z_(T U)$: Twisted sector, untwisted boundary conditions
- $Z_(T T)$: Twisted sector, twisted boundary conditions

=== Relation to Ising model

At the self-dual radius $R = sqrt(2)$, the $ZZ_2$ orbifold of the compactified boson is equivalent to *two copies of the Ising CFT*:
$ "Orbifold"(c=1, R=sqrt(2)) tilde.eq "Ising" times "Ising" $

The twisted sector ground state corresponds to the spin field $sigma$ with $h = 1\/16$.

== Moduli space of $c = 1$ theories

The space of $c = 1$ CFTs forms a connected moduli space with the following structure:

#figure(
  image("./figs/module_space.jpg", width: 80%),
  caption: [The moduli space of $c=1$ conformal field theories. The horizontal line represents the compactified boson at radius $R$, ranging from $R = 0$ (equivalent to $R = infinity$ by T-duality) to the self-dual point $R = sqrt(2)$. The vertical direction represents the $ZZ_2$ orbifold branch. Special points include: the self-dual radius where additional symmetry enhancement occurs, the $S U(2)_1$ point, and the connection to the Ising${}^2$ theory at the orbifold of the self-dual radius.],
) <module_space>

Key features of the moduli space:

#table(
  columns: 2,
  align: (left, left),
  stroke: 0.6pt,
  inset: 8pt,
  table.header([*Theory*], [*Description*]),
  [Free boson ($R -> infinity$)], [Non-compact boson, continuous spectrum],
  [Compactified boson ($R$ finite)], [Discrete momentum $n\/R$, winding $w$],
  [Self-dual point ($R = sqrt(2)$)], [Enhanced $S U(2)_1 times S U(2)_1$ symmetry],
  [Orbifold line], [$ZZ_2$ orbifold, twisted sectors with $h = 1\/16$],
  [Orbifold at $R = sqrt(2)$], [Equivalent to Ising $times$ Ising],
)
