== XY model, compact boson, Luttinger liquid and BKT transition

=== The XY model and its continuum limit

The classical XY model in two dimensions consists of unit spins $bold(s)_i = (cos theta_i, sin theta_i)$ on a lattice, with Hamiltonian
$ H = -J sum_(chevron.l i, j chevron.r) cos(theta_i - theta_j). $
At low temperature the spins are locally aligned, and the energy is dominated by smooth configurations. Expanding the cosine for slowly varying $theta$ gives the Gaussian (free boson) theory
$ H approx frac(J, 2) integral d^2 x (nabla theta)^2. $
Because the original spin is an angle, the field $theta$ is _compact_: $theta equiv theta + 2 pi$. This periodicity has a profound consequence — the theory admits vortex configurations, around which $theta$ winds by $2 pi n$,
$ integral.cont d bold(l) dot nabla theta = 2 pi n, quad n in bb(Z). $
A single vortex in a system of linear size $L$ costs energy $E = pi J ln L$, but carries entropy $ln L^2 = 2 ln L$ from its possible positions. The free energy of an isolated vortex is therefore
$ F = (pi J - 2 T) ln L, $
which changes sign at $T_("BKT") = pi J \/ 2$: above this temperature vortices proliferate and destroy quasi-long-range order. This is the essence of the Berezinskii–Kosterlitz–Thouless (BKT) transition.

=== The compact boson CFT

The continuum theory is the free compact boson with action
$ S = frac(g, 4 pi) integral d^2 z partial phi overline(partial) phi, quad phi equiv phi + 2 pi R, $
which is conformally invariant with central charge $c = 1$. The compactification quantizes the allowed operator content. The local operators are:

- _Vertex operators_ $V_(n, m)(z, overline(z)) = :e^(i n phi\/R + i m R overline(phi)):$ carrying electric charge $n$ and winding (vortex) charge $m$, with conformal weights
$ h = frac(1, 2)(n/R + m R)^2, quad overline(h) = frac(1, 2)(n/R - m R)^2. $
- The $U(1)$ currents $J = i partial phi$ and $overline(J) = i overline(partial) phi$, with weights $(1, 0)$ and $(0, 1)$.

The duality $R arrow.l.r 1\/R$ exchanging $n arrow.l.r m$ is the CFT remnant of the Kramers–Wannier / vortex–spin duality of the XY model: the spin field is dual to the vortex operator. The BKT point of the XY model corresponds to the radius at which the vortex operator of unit winding becomes marginal, $Delta_("vortex") = m^2 R^2 = 2$.

=== Luttinger liquids and bosonization

One-dimensional quantum fluids of interacting fermions or spins do not form Fermi liquids; their low-energy physics is instead captured by the _Luttinger liquid_, which is nothing but the compact boson CFT applied to (1+1) dimensions. Bosonization identifies the fermion density fluctuations with the boson,
$ rho(x) - rho_0 = -frac(1, sqrt(pi)) partial_x phi, $
and the fermion field itself with a vertex operator,
$ psi_(r)(x) tilde :e^(i r k_F x + i sqrt(pi)(r phi(x) - theta(x))):, quad r = plus.minus, $
where $r = plus.minus$ labels right- and left-moving branches and $[phi(x), theta(y)] = i Theta(y - x)$.

Interactions renormalize the theory only through two parameters: the velocity $v$ and the _Luttinger parameter_ $K$ (equivalently, the compactification radius). The Hamiltonian remains Gaussian,
$ H = frac(v, 2) integral d x [K (partial_x theta)^2 + frac(1, K) (partial_x phi)^2], $
but all correlation functions acquire interaction-dependent exponents. For example, the equal-time fermion Green's function decays as a power law,
$ chevron.l psi(x) psi^dagger (0) chevron.r tilde |x|^(-(K + K^(-1))/2), $
and the $2 k_F$ density–density and superconducting correlations decay with exponents $2K$ and $2\/K$ respectively. The non-Fermi-liquid character — power laws with continuously varying exponents, no quasiparticle residue — is a direct consequence of conformal invariance plus compactness.

Backscattering and umklapp processes appear as vertex operators $cos(beta phi)$ with scaling dimension $Delta = beta^2 K \/ 4 pi$; they are relevant only for sufficiently small $K$, which is how Mott insulating phases open a gap.

=== The BKT transition

The BKT transition is the phase transition driven by the relevancy of the least irrelevant vortex/umklapp operator. Writing $y$ for the vortex fugacity and $x = 2 - pi K$ for the deviation of the stiffness from its critical value, the renormalization group flow to one loop is
$ (d x) / (d ell) = y^2, quad (d y) / (d ell) = x y. $
These are the celebrated Kosterlitz recursion relations. Their key features:

- The flow conserves $x^2 - y^2$, giving hyperbolic trajectories. The separatrix $x = -y$ (for $y arrow.r 0$) is the phase boundary.
- Below the transition ($x < 0$, $y arrow.r 0$) vortices are bound in pairs: the theory flows to a line of fixed points $y = 0$, $x < 0$, described by the free compact boson. Correlations decay as power laws with exponent set by $K$.
- Above it, $y$ grows under the flow, vortex pairs unbind, and the correlation length diverges with the essential singularity
$ xi tilde exp(b / sqrt(T - T_("BKT"))), $
rather than a power law — the hallmark of an infinite-order transition.

Two universal predictions follow from the CFT/RG analysis. First, at the transition the vortex operator is exactly marginal, so the stiffness (superfluid density) takes the universal value
$ K(T_("BKT")) = 2 / pi, $
i.e. the helicity modulus jumps discontinuously from $2 T_("BKT") \/ pi$ to zero — the Nelson–Kosterlitz universal jump. Second, the spin (vertex operator) correlator at criticality decays with the universal exponent
$ chevron.l bold(s)(x) dot bold(s)(0) chevron.r tilde |x|^(-1\/4). $

The same RG equations govern the Luttinger liquid at the marginally relevant umklapp point (e.g. the Heisenberg spin-$1\/2$ chain, where the marginally irrelevant coupling produces the famous logarithmic corrections to the $1\/r$ spin correlator), the sine–Gordon model, and the $S U(2)_1$ WZW point where the marginal operator is $J^a overline(J)^a$. This universality is why the compact boson occupies a central place in two-dimensional CFT.

== WZW model

In this section, we introduce the Wess–Zumino–Witten (WZW) model, a two-dimensional conformal field theory with affine Lie algebra symmetry. Such model possess additional continuous symmetries other than the conformal symmetry. From the CFT viewpoint, the model provides a concrete realization of Kac–Moody currents and their highest-weight representations.

A useful motivation is the following: when a nonlinear sigma model has a Lie-group target space and is supplemented by the Wess–Zumino term, the theory acquires conserved chiral currents. At the conformal fixed point, these currents generate an affine Lie algebra, which strongly constrains the spectrum and correlation functions. This is why the current algebra is the natural starting point.

Another motivation is the CS/WZW correspondence as a subset of AdS/CFT correspondence, which states the Chern–Simons theory's physical states in three dimensions corresponds to the conformal block of WZW models (ref to Witten's 1989 paper on QFT and jones polynomial). In this correspondence, the level $k$ of the WZW model also is the level $k$ of the Chern–Simons theory, and the affine Lie algebra symmetry of the WZW model reflects the gauge symmetry of the Chern–Simons theory.

The current algebra is encoded by the OPE
$ J^a (z) J^b (w) approx (k delta^(a b)) / (z - w)^2 + (i f^(a b c) J^c (w)) / (z - w). $
where $k$ is the level and $f^(a b c)$ are the structure constants of the finite-dimensional Lie algebra of
$ [X_a, X_b] = i f_(a b)^(c) X_c . $

The mode-expansion of current algebra $J^a = sum_n J^a_n z^(-n-1)$ satisfies 
$ [J^a_m, J^b_n] = frac(1, (2 pi i )^2)[integral.cont z^n J^a, integral.cont omega^m J^b]
\ =i f^(a b c) J^c_(m+n) + k m delta^(a b) delta_(m+n) . $

This is the central extension of original Lie algebra $[J^a_m, J^b_n]=i f^(a b c) J^c_(m+n)$, with $k m delta^(a b) delta_(m+n)$ is the central term. This is the affine Kac-Moody algebra. 

The energy-momentum tensor is given by the Sugawara construction,

$ T(z) = 1 / (2 (k + h^∨)) colon J^a(z) J^a(z) colon. $
Here $h^∨$ is the dual Coxeter number, which is defined as $-2h^∨ delta^(a b) = f^(a c)_d f^(b d)_c$. The corresponding central charge is

$ c = (k "dim"(frak(g))) / (k + h^∨). $
where $"dim"(frak(g))$ is the dimension of the Lie algebra $frak(g)$.

Primary fields are labeled by highest-weight representations of the affine algebra. Their conformal dimensions are

$ Delta_(lambda) = C_2(lambda) / (2 (k + h^∨)). $
Here $C_2(lambda)$ is the quadratic Casimir for the representation labeled by $lambda$. The coexistence of affine Lie and Virasoro symmetries makes the WZW model highly constrained and analytically tractable, with broad applications in statistical mechanics, string theory, and condensed matter physics.

Moreover, the Virasoro generate of WZW model is:
$ L_n = sum_(k <= -1)J_k^a J_(n-k)^a + sum_(k>-1)J_(n-k)^a J_k = sum_k :J_k^a J_(n-k)^a: $

The free compact boson has a conserved current, which is simple, $partial_z theta, partial_(overline(z)) theta$. 

Generators $J(z) = sum_n J_n z^(-n-1)$. Its mode expansion is $J_n = i sqrt(2) alpha_n$, and the commutation relation is $[J_m, J_n] = k m delta_(m+n)$. The energy-momentum tensor is $T(z) = 1/2 :J(z) J(z):$, and the Virasoro generator is $L_n = 1/2 sum_k :J_k J_(n-k):$.
 
 For example, $U(1)$ Kac-Moody algebra is the symmetry of the WZW model, which is a free boson CFT with central charge $c = 1$. The primary fields are vertex operators $V_alpha(z) = :e^(i alpha phi(z)):$, with conformal dimensions $Delta_alpha = alpha^2 / 2$. The fusion rules are given by the addition of charges, $V_alpha times V_beta = V_(alpha + beta)$.

Moreover, the $S U(2)_k$ WZW model has central charge $c = 3k/(k+2)$ and primary fields labeled by spin $j = 0, 1/2, ..., k/2$, with conformal dimensions $Delta_j = j(j+1)/(k+2)$. $k=1, c=1$ is the same as the free boson CFT. In the classical limit $k arrow.r infinity, c=3$, the WZW model reduces to the classical sigma model on the group manifold, just 3 non-interacting bosons.

The fusion rules are given by the tensor product of representations, truncated to the allowed range of spins. Here $J^a_n$ has color index $a = 1, 2, 3$.