== WZW model

In this section, we introduce the Wess–Zumino–Witten (WZW) model, a two-dimensional conformal field theory with affine Lie algebra symmetry. From the CFT viewpoint, the model provides a concrete realization of Kac–Moody currents and their highest-weight representations.

A useful motivation is the following: when a nonlinear sigma model has a Lie-group target space and is supplemented by the Wess–Zumino term, the theory acquires conserved chiral currents. At the conformal fixed point, these currents generate an affine Lie algebra, which strongly constrains the spectrum and correlation functions. This is why the current algebra is the natural starting point.

Another motivation is the CS/WZW correspondence as a subset of AdS/CFT correspondence, which states the Chern–Simons theory's physical states in three dimensions corresponds to the conformal block of WZW models (ref to Witten's 1989 paper on QFT and jones polynomial). In this correspondence, the level $k$ of the WZW model also is the level $k$ of the Chern–Simons theory, and the affine Lie algebra symmetry of the WZW model reflects the gauge symmetry of the Chern–Simons theory.

The current algebra is encoded by the OPE
$ J^a (z) J^b (w) approx (k delta^(a b)) / (z - w)^2 + (i f^(a b c) J^c (w)) / (z - w). $
where $k$ is the level and $f^(a b c)$ are the structure constants of the finite-dimensional Lie algebra of
$ [X_a, X_b] = i f_(a b)^(c) X_c . $

The mode-expansion of current algebra $J^a = sum_n J^a_n z^(-n-1)$ satisfies 
$ [J^a_m, J^b_n] = frac(1, (2 pi i )^2)[integral.cont z^n J^a, integral.cont omega^m J^b]
\ =i f^(a b c) J^c_(m+n) + k m delta^(a b) delta_(m+n) . $

This is the central extension of original Lie algebra, with $k m delta^(a b) delta_(m+n)$ is the central term. This is the affine Kac-Moody algebra. 

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