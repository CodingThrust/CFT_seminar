#set document(title: "Critical Ising Chain: One- and Two-Point Correlation Functions", author: "Zhaohui")
#set page(paper: "a4", margin: 2.5cm, numbering: "1")
#set text(font: "Libertinus Serif", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 0.8em)

#align(center)[
  #text(size: 18pt, weight: "bold")[
    Critical Ising Chain: One-Point Functions in BCFT\
    and Two-Point Functions in CFT
  ]
  #v(1em)
  Mini-project report
  #v(0.5em)
  #datetime.today().display()
]


= Setup

We study the critical transverse-field Ising (TFI) chain
$ H = - sum_i sigma_i^x - sum_i sigma_i^z sigma_(i+1)^z, $
whose continuum limit is the Ising CFT with central charge $c = 1\/2$.
The two relevant primary operators are the spin field $sigma$ (scaling
dimension $Delta_sigma = 1\/8$) and the energy field $epsilon$
($Delta_epsilon = 1$). On the lattice they correspond to
$ sigma_i^z <-> sigma, quad quad sigma_i^x <-> c_0 + c_1 epsilon, $
i.e. the transverse spin contains the identity plus the energy operator.

We diagonalize $H$ exactly (sparse Lanczos, `Arpack.eigs`) for chains of
length $L = 10, 12, 14, 16$ and compute ground-state expectation values.

= One-point function: free boundary conditions (BCFT)

== Theory

On the upper half plane with a boundary condition $a$, the one-point
function of a primary is fixed by conformal invariance up to a constant:
$ chevron.l phi(x) chevron.r_a = A_a (2 y)^(-Delta), $
where $y$ is the distance to the boundary. Mapping the half plane to a
strip of width $L$ (free boundaries on both sides) gives
$ chevron.l phi(x) chevron.r = A lr([(L/pi) sin (pi x/L)])^(-Delta). $

For the free boundary condition the $bb(Z)_2$ symmetry is preserved, so
$chevron.l sigma chevron.r = 0$; the simplest nonzero one-point function
is that of the energy operator $epsilon$. On the lattice we therefore
measure $chevron.l sigma_i^x chevron.r$, which contains a bulk constant
plus the $epsilon$ profile:
$ chevron.l sigma^x (x) chevron.r = 2/pi + A lr([(L/pi) sin (pi x/L)])^(-Delta_epsilon). $

Note that the bulk constant $c_0 = 2/pi$ is known exactly from the Jordan-Wigner solution of the TFI chain.
$ chevron.l sigma^x chevron.r_("bulk") = frac(1, pi) integral_0^(pi) frac(h-J cos k, sqrt(h^2+J^2-2h J cos k))d k = frac(2, pi) $

== Results

The exact-diagonalization profile for the open chain is fitted to the
formula above with the bulk constant fixed to its known value
$c_0 = 2\/pi$, dropping the two outermost sites on each side.
@fig-onepoint shows the data and fit for $L = 16$.

#figure(
  image("free_BC_onepoint_fit.png", width: 75%),
  caption: [One-point function $chevron.l sigma^x (x) chevron.r$ for the
    open (free BC) chain, $L = 16$, with the BCFT fit.],
) <fig-onepoint>

The fitted exponent depends on $L$ through subleading corrections;
extrapolating linearly in $1\/L$ (@fig-extrap) gives
$ Delta_epsilon = 1.07, $
consistent with the BCFT value $Delta_epsilon = 1$.

#figure(
  image("free_BC_extrapolation.png", width: 75%),
  caption: [Finite-size extrapolation of the fitted one-point exponent.],
) <fig-extrap>

= Two-point functions: periodic boundary conditions (CFT)

== Theory

On a ring of circumference $L$, translational and conformal invariance
fix the two-point function of a primary to
$ chevron.l phi(r) phi(0) chevron.r = A lr([(L/pi) sin (pi r/L)])^(-2 Delta), $
the "chord distance" version of the plane result $r^(-2 Delta)$.

We compute the connected, translation-averaged correlators
$ C_(z z)(r) = chevron.l sigma_i^z sigma_(i+r)^z chevron.r, quad quad
  C_(x x)(r) = chevron.l sigma_i^x sigma_(i+r)^x chevron.r - chevron.l sigma^x chevron.r^2, $
which probe the spin ($Delta_sigma = 1\/8$) and energy
($Delta_epsilon = 1$) primaries, respectively.

== Results

@fig-zz and @fig-xx show the correlators for $L = 16$ together with the
CFT fits (points at $r = 1$ are excluded from the fit as short-distance
lattice artifacts), and the extrapolations of the fitted exponents in
$1\/L$.

#figure(
  image("PBC_ZZ_fit.png", width: 100%),
  caption: [$C_(z z)(r)$ on the ring ($L = 16$) with CFT fit, and
    finite-size extrapolation of the exponent.],
) <fig-zz>

#figure(
  image("PBC_XX_fit.png", width: 100%),
  caption: [Connected $C_(x x)(r)$ on the ring ($L = 16$) with CFT fit,
    and finite-size extrapolation of the exponent.],
) <fig-xx>

The extrapolated scaling dimensions are
$ Delta_sigma = 0.125 quad ("exact:" 1/8), quad quad
  Delta_epsilon = 1.02 quad ("exact:" 1). $

= Summary

#table(
  columns: 4,
  align: (left, center, center, center),
  table.header[Quantity][Observable][Fitted $Delta$ ($L -> infinity$)][Exact $Delta$],
  [One-point, free BC], [$sigma^x$ ($epsilon$)], [1.07], [1],
  [Two-point, PBC], [$sigma^z sigma^z$ ($sigma$)], [0.125], [1\/8],
  [Two-point, PBC], [$sigma^x sigma^x$ ($epsilon$)], [1.02], [1],
)

Exact diagonalization of the critical TFI chain at modest sizes,
combined with the (B)CFT functional forms and a $1\/L$ extrapolation,
reproduces the Ising CFT scaling dimensions to a few percent. The
finite-size corrections are strongest for the boundary one-point fit,
where subleading boundary contributions compete with the small
one-point amplitude.

*Code:* `free_BC_corr.jl` (one-point, open chain), `PBC_corr.jl`
(two-point, ring).
