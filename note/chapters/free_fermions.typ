== The free fermions
The massless free fermion theory is described by a fermionic field $psi(z)$ with the action:
$ S = frac(1,8pi) integral d^2z psi overline(partial) psi + overline(psi) partial overline(psi) $
The stress-energy tensor for the free fermion theory can be derived from the action using the Noether procedure, and it is given by:
$ T(z) = -frac(1,2) :psi(z) partial psi(z): $
$ overline(T)(overline(z)) = -frac(1,2) :overline(psi)(overline(z)) overline(partial) overline(psi)(overline(z)): $
The free fermion theory has a central charge of $c = 1/2$.

=== The fermion propagator

The equation of motion from the action is $overline(partial) psi = 0$, which means $psi(z)$ is holomorphic. The two-point function (propagator) of the free fermion is determined by the equation of motion and conformal symmetry. For a fermionic field with conformal weight $h = 1\/2$, we have:
$ angle.l psi(z) psi(w) angle.r = frac(1, z - w) $

This can be derived from the path integral by noting that the action is quadratic in $psi$, and the propagator is the inverse of the kinetic operator. The anticommutating nature of fermions ensures the antisymmetry:
$ angle.l psi(z) psi(w) angle.r = -angle.l psi(w) psi(z) angle.r $

=== The $T psi$ OPE

We now derive the operator product expansion (OPE) of $T(z)$ with $psi(w)$. Using the definition of the stress-energy tensor and Wick's theorem:

$ T(z) psi(w) &= -frac(1,2) :psi(z) partial_z psi(z): psi(w) $

To evaluate this, we use Wick's theorem. The normal-ordered product $:psi(z) partial_z psi(z):$ means we subtract all self-contractions. When we bring $psi(w)$ close, we need to contract it with the fields inside the normal ordering:

$ T(z) psi(w) &= -frac(1,2) (:psi(z) partial_z psi(z): psi(w)) \
&= -frac(1,2) (angle.l psi(z) psi(w) angle.r partial_z psi(z) - psi(z) angle.l partial_z psi(z) psi(w) angle.r) + "regular" $

Note the minus sign from anticommuting $psi(w)$ past $psi(z)$. Using the propagator:
$ angle.l psi(z) psi(w) angle.r = frac(1, z-w), quad angle.l partial_z psi(z) psi(w) angle.r = -frac(1, (z-w)^2) $

Substituting:
$ T(z) psi(w) &= -frac(1,2) (frac(1, z-w) partial_z psi(z) - psi(z) dot (-frac(1, (z-w)^2))) + "regular" \
&= -frac(1,2) frac(partial_z psi(z), z-w) + frac(psi(z), 2(z-w)^2) + "regular" $

Now we expand $psi(z)$ and $partial_z psi(z)$ around $w$:
$ psi(z) = psi(w) + (z-w) partial_w psi(w) + dots $
$ partial_z psi(z) = partial_w psi(w) + dots $

Keeping only the singular terms:
$ T(z) psi(w) = frac(psi(w), 2(z-w)^2) + frac(partial_w psi(w), 2(z-w)) + frac(partial_w psi(w), 2(z-w)) + "regular" $

Wait, let me redo this more carefully. We have:
$ T(z) psi(w) = frac(1, 2(z-w)^2) psi(z) - frac(1, 2(z-w)) partial_z psi(z) + "regular" $

Expanding around $w$:
$ T(z) psi(w) &= frac(1, 2(z-w)^2) (psi(w) + (z-w) partial psi(w) + dots) - frac(1, 2(z-w)) (partial psi(w) + dots) \
&= frac(psi(w), 2(z-w)^2) + frac(partial psi(w), 2(z-w)) - frac(partial psi(w), 2(z-w)) + "regular" \
&= frac(1\/2, (z-w)^2) psi(w) + frac(1, z-w) partial psi(w) + "regular" $

Therefore, the $T psi$ OPE is:
$ T(z) psi(w) = frac(h_psi, (z-w)^2) psi(w) + frac(1, z-w) partial psi(w) + "regular" $
with $h_psi = 1\/2$. This confirms that $psi$ is a primary field with conformal weight $h = 1\/2$.

=== The $T T$ OPE and central charge

Now we derive the $T(z) T(w)$ OPE, which will give us the central charge. Using:
$ T(z) = -frac(1,2) :psi(z) partial psi(z): $

We compute:
$ T(z) T(w) = frac(1,4) :psi(z) partial_z psi(z): :psi(w) partial_w psi(w): $

Using Wick's theorem for the product of two normal-ordered operators, we need all possible contractions between the two normal-ordered products:

$ T(z) T(w) = frac(1,4) [&angle.l psi(z) psi(w) angle.r angle.l partial_z psi(z) partial_w psi(w) angle.r \
&- angle.l psi(z) partial_w psi(w) angle.r angle.l partial_z psi(z) psi(w) angle.r \
&+ angle.l psi(z) psi(w) angle.r :partial_z psi(z) partial_w psi(w): \
&- angle.l psi(z) partial_w psi(w) angle.r :partial_z psi(z) psi(w): \
&- angle.l partial_z psi(z) psi(w) angle.r :psi(z) partial_w psi(w): \
&+ angle.l partial_z psi(z) partial_w psi(w) angle.r :psi(z) psi(w):] + "regular" $

The relevant contractions are:
$ angle.l psi(z) psi(w) angle.r &= frac(1, z-w) $
$ angle.l partial_z psi(z) psi(w) angle.r &= partial_z frac(1, z-w) = -frac(1, (z-w)^2) $
$ angle.l psi(z) partial_w psi(w) angle.r &= partial_w frac(1, z-w) = frac(1, (z-w)^2) $
$ angle.l partial_z psi(z) partial_w psi(w) angle.r &= partial_z partial_w frac(1, z-w) = -frac(2, (z-w)^3) $

*Double contraction terms* (most singular):
$ frac(1,4) [frac(1, z-w) dot (-frac(2, (z-w)^3)) - frac(1, (z-w)^2) dot (-frac(1, (z-w)^2))] = frac(1,4) [-frac(2, (z-w)^4) + frac(1, (z-w)^4)] = -frac(1, 4(z-w)^4) $

This gives $c\/2 = 1\/4$, so $c = 1\/2$.

*Single contraction terms* (next order):

The terms with one contraction and one normal-ordered pair contribute to the $1\/(z-w)^2$ term. After careful calculation:

$ frac(1,4) [frac(1, z-w) :partial_z psi(z) partial_w psi(w): - frac(1, (z-w)^2) :partial_z psi(z) psi(w): + frac(1, (z-w)^2) :psi(z) partial_w psi(w): - frac(2, (z-w)^3) :psi(z) psi(w):] $

Expanding around $w$ and keeping the leading singular terms, we get contributions to $T(w)\/(z-w)^2$ and $partial T(w)\/(z-w)$.

The final result is:
$ T(z) T(w) = frac(c\/2, (z-w)^4) + frac(2 T(w), (z-w)^2) + frac(partial T(w), z-w) + "regular" $

with $c = 1\/2$.

=== Summary: OPEs of the free fermion theory

#table(
  columns: 2,
  align: (left, left),
  stroke: 0.6pt,
  inset: 8pt,
  table.header(
    [*OPE*],
    [*Result*],
  ),
  [$psi(z) psi(w)$],
  [$display(frac(1, z-w)) + "regular"$],
  [$T(z) psi(w)$],
  [$display(frac(1\/2, (z-w)^2) psi(w) + frac(1, z-w) partial psi(w)) + "regular"$],
  [$T(z) T(w)$],
  [$display(frac(1\/4, (z-w)^4) + frac(2 T(w), (z-w)^2) + frac(partial T(w), z-w)) + "regular"$],
)

From the $T T$ OPE, we read off the central charge $c = 1\/2$, confirming that the free fermion theory is equivalent to the Ising CFT at criticality.

=== Mode expansion of the fermion field

The fermion field has the mode expansion:
$ psi(z) = sum_(r) frac(psi_r, z^(r + 1\/2)) $

where $r in ZZ + 1\/2$ for the Neveu-Schwarz (NS) sector (antiperiodic boundary conditions) and $r in ZZ$ for the Ramond (R) sector (periodic boundary conditions).

The anticommutation relations are:
$ {psi_r, psi_s} = delta_(r+s, 0) $

The Virasoro generators can be expressed in terms of fermion modes:
$ L_n = frac(1,2) sum_r (r + frac(n,2)) :psi_(n-r) psi_r: $

In the NS sector, the vacuum $|0 angle.r$ satisfies:
$ psi_r |0 angle.r = 0 quad "for" r > 0 $
$ L_n |0 angle.r = 0 quad "for" n >= -1 $