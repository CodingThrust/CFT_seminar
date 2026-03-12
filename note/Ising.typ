// Standalone note: Classical-to-Quantum Ising mapping
#import "@preview/cetz:0.3.4": canvas, draw

#set page(paper: "a4", margin: 2.5cm, numbering: "1")
#set text(size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 0.8em)
#set math.equation(numbering: "(1)")

#align(center)[
  #text(size: 18pt, weight: "bold")[Mapping the 2D Classical Ising Model \ to the 1+1D Quantum Ising Model]
  #v(0.5em)
  #text(size: 12pt)[Zhaohui Zhi]
  #v(1.5em)
]

= From Classical Partition Functions to Quantum Circuits

== The transfer matrix and quantum circuits

A central idea connecting classical statistical mechanics to quantum mechanics is the _transfer matrix_ method. Consider a classical statistical model defined on a lattice. Its partition function can be written as

$ Z = tr(e^(-beta H)) = tr(T^N), $

where $T$ is the transfer matrix and $N$ is the number of rows (or time slices). The key observation is that the transfer matrix of a classical model plays the same role as the time-evolution operator $e^(-tau hat(H))$ in quantum mechanics (in imaginary time). In other words, each application of $T$ corresponds to one step of imaginary-time evolution --- or equivalently, one layer of a quantum circuit.

This transfer-matrix/quantum-circuit correspondence provides a powerful dictionary:

#align(center)[
  #table(
    columns: 2,
    align: (center, center),
    stroke: 0.5pt,
    inset: 8pt,
    [*Classical statistical model*], [*Quantum system*],
    [Partition function $Z = tr(T^N)$], [Imaginary-time path integral],
    [Transfer matrix $T$], [Imaginary-time evolution $e^(-tau hat(H))$],
    [Row-to-row transfer], [One layer of quantum circuit],
    [Classical spins $sigma_i = plus.minus 1$], [Computational basis $|sigma_i angle.r$],
    [Inverse temperature $beta$], [Imaginary time $tau$],
  )
]

We now illustrate this correspondence concretely for the 2D classical Ising model on a square lattice.

== The 2D classical Ising model

Consider a square lattice with classical Ising spins $sigma_i = plus.minus 1$ placed on each vertex. The Hamiltonian is

$ H = -J sum_(angle.l i, j angle.r) sigma_i sigma_j, $

where the sum is over nearest-neighbor pairs. We split the interactions into _horizontal_ bonds (within a row) and _vertical_ bonds (between adjacent rows). Denoting the spins in row $n$ collectively as $bold(sigma)_n = (sigma_(n,1), sigma_(n,2), dots, sigma_(n,L))$, the partition function on an $N times L$ lattice with periodic boundary conditions is

$ Z = sum_({sigma}) product_(n=1)^(N) exp(beta_h sum_j sigma_(n,j) sigma_(n,j+1) + beta_v sum_j sigma_(n,j) sigma_(n+1,j)), $

where $beta_h = beta J_h$ and $beta_v = beta J_v$ are the horizontal and vertical couplings respectively. In the isotropic case $beta_h = beta_v equiv K$.

#v(0.8em)
// ========== FIGURE 1: Square lattice with classical spins ==========
#let fig1 = {
  import draw: *

  let rows = 5
  let cols = 6
  let dx = 1.0
  let dy = 1.0

  // Draw horizontal bonds
  for r in range(rows) {
    for c in range(cols - 1) {
      line(
        (c * dx, r * dy),
        ((c + 1) * dx, r * dy),
        stroke: 0.8pt + gray,
      )
    }
  }
  // Draw vertical bonds
  for r in range(rows - 1) {
    for c in range(cols) {
      line(
        (c * dx, r * dy),
        (c * dx, (r + 1) * dy),
        stroke: 0.8pt + gray,
      )
    }
  }
  // Draw spins on vertices
  for r in range(rows) {
    for c in range(cols) {
      let spin-up = calc.rem(r + c, 2) == 0
      circle(
        (c * dx, r * dy),
        radius: 0.18,
        fill: if spin-up { blue.lighten(30%) } else { red.lighten(30%) },
        stroke: 0.6pt + black,
      )
      content(
        (c * dx, r * dy),
        text(size: 7pt, weight: "bold",
          if spin-up { $+$ } else { $-$ }
        ),
      )
    }
  }

  // Labels
  content((2.5 * dx, -0.7 * dy), text(size: 9pt)[$arrow.r quad j$])
  content((-0.7 * dx, 2 * dy), angle: 90deg, text(size: 9pt)[$arrow.t quad n$])

  // Brace for "row n"
  content((cols * dx + 0.3, 2 * dy), text(size: 9pt)[$bold(sigma)_n$])
}

#figure(
  canvas(length: 0.75cm, fig1),
  caption: [Square lattice with classical Ising spins $sigma_i = plus.minus 1$ on each vertex.
  Blue ($+$) and red ($-$) denote spin-up and spin-down respectively.
  Horizontal bonds carry coupling $beta_h$ and vertical bonds carry coupling $beta_v$.]
) <fig:lattice>

#v(0.5em)

== Decomposing the transfer matrix into tensor building blocks

The transfer matrix $T$ maps one row of spins to the next. Its matrix elements are

$ angle.l bold(sigma)^prime | T | bold(sigma) angle.r = exp(beta_h sum_j sigma^prime_j sigma^prime_(j+1) + beta_v sum_j sigma_j sigma^prime_j). $

The crucial insight is that we can factorize $T$ into a product of two simpler pieces:

$ T = T_"vertical" dot T_"horizontal" = product_j e^(beta_v sigma_j sigma^prime_j) dot product_j e^(beta_h sigma^prime_j sigma^prime_(j+1)). $

Now we promote the classical spins to quantum operators. In the computational basis $|sigma angle.r$ (eigenstates of $hat(Z)$), we identify:

- *Diagonal interaction (vertical bond):* The Boltzmann weight $e^(beta_v sigma_j sigma_(j+1)^prime)$ acts _between_ two adjacent rows. When interpreted as a matrix in the $sigma, sigma^prime$ basis, it takes the form:

  $ T_"vert" = mat(e^(beta_v), e^(-beta_v); e^(-beta_v), e^(beta_v)) prop e^(beta^*_v hat(X)), $

  where $hat(X)$ is the Pauli-$X$ operator and the dual coupling $beta^*_v$ is defined by

  $ e^(-2 beta^*_v) = tanh(beta_v), quad "i.e.," quad beta^*_v = 1/2 ln(1 + delta) = 1/2 "arctanh"(e^(-2 beta_v)). $

  To verify: $e^(beta^*_v hat(X)) = cosh(beta^*_v) hat(I) + sinh(beta^*_v) hat(X)$, which has matrix elements $e^(beta^*_v hat(X))_(sigma sigma^prime) prop e^(beta_v sigma sigma^prime)$.

- *Off-diagonal interaction (horizontal bond):* The Boltzmann weight $e^(beta_h sigma_j sigma_(j+1))$ acts _within_ a single row. Since $sigma_j$ and $sigma_(j+1)$ are in the $hat(Z)$-eigenbasis, this is simply

  $ T_"horiz" = e^(beta_h hat(Z)_j hat(Z)_(j+1)). $

Therefore the full transfer matrix is a product of commuting two-body gates:

$ T = product_j e^(beta^*_v hat(X)_j) dot product_j e^(beta_h hat(Z)_j hat(Z)_(j+1)), $

which is _exactly_ one layer of a quantum circuit composed of single-qubit rotations $e^(beta^*_v X)$ and nearest-neighbor $Z Z$-interactions $e^(beta_h Z Z)$.

#v(0.8em)
// ========== FIGURE 2: Tensor building blocks and quantum circuit ==========
#let fig2 = {
  import draw: *

  // --- Left panel: tensor network on bonds ---
  let rows = 4
  let cols = 4
  let dx = 1.2
  let dy = 1.2

  // Draw bonds as thick lines
  for r in range(rows) {
    for c in range(cols - 1) {
      line(
        (c * dx, r * dy),
        ((c + 1) * dx, r * dy),
        stroke: 1.2pt + gray,
      )
    }
  }
  for r in range(rows - 1) {
    for c in range(cols) {
      line(
        (c * dx, r * dy),
        (c * dx, (r + 1) * dy),
        stroke: 1.2pt + gray,
      )
    }
  }

  // Draw tensors on vertical bonds (blue rectangles)
  for r in range(rows - 1) {
    for c in range(cols) {
      rect(
        (c * dx - 0.2, (r + 0.35) * dy),
        (c * dx + 0.2, (r + 0.65) * dy),
        fill: blue.lighten(70%),
        stroke: 0.8pt + blue,
      )
    }
  }

  // Draw tensors on horizontal bonds (red rectangles)
  for r in range(rows) {
    for c in range(cols - 1) {
      rect(
        ((c + 0.35) * dx, r * dy - 0.18),
        ((c + 0.65) * dx, r * dy + 0.18),
        fill: red.lighten(70%),
        stroke: 0.8pt + red,
      )
    }
  }

  // Draw vertices (small black dots)
  for r in range(rows) {
    for c in range(cols) {
      circle(
        (c * dx, r * dy),
        radius: 0.08,
        fill: black,
      )
    }
  }

  // Label
  content(((cols - 1) / 2 * dx, -0.8 * dy),
    text(size: 8pt)[Tensor network on bonds])

  // --- Arrow ---
  let arrow-x = cols * dx + 0.8
  line(
    (arrow-x - 0.1, (rows - 1) / 2 * dy),
    (arrow-x + 1.5, (rows - 1) / 2 * dy),
    stroke: 1.2pt,
    mark: (end: "stealth", fill: black),
  )

  // Building block labels above arrow
  content((arrow-x + 0.7, (rows - 1) / 2 * dy + 0.7),
    text(size: 8pt)[building blocks])

  // --- Middle: building blocks ---
  let bx = arrow-x + 3.5

  // Vertical bond tensor (blue)
  content((bx, (rows - 1) / 2 * dy + 1.2),
    text(size: 9pt, fill: blue)[$e^(beta^*_v X)$])
  line(
    (bx, (rows - 1) / 2 * dy + 0.8),
    (bx, (rows - 1) / 2 * dy + 0.1),
    stroke: 1.0pt + gray,
  )
  rect(
    (bx - 0.35, (rows - 1) / 2 * dy + 0.15),
    (bx + 0.35, (rows - 1) / 2 * dy + 0.65),
    fill: blue.lighten(70%),
    stroke: 0.8pt + blue,
  )
  circle((bx, (rows - 1) / 2 * dy + 0.8), radius: 0.06, fill: black)
  circle((bx, (rows - 1) / 2 * dy + 0.1), radius: 0.06, fill: black)

  // Horizontal bond tensor (red)
  content((bx, (rows - 1) / 2 * dy - 0.7),
    text(size: 9pt, fill: red)[$e^(beta_h Z Z)$])
  line(
    (bx - 0.5, (rows - 1) / 2 * dy - 1.2),
    (bx + 0.5, (rows - 1) / 2 * dy - 1.2),
    stroke: 1.0pt + gray,
  )
  rect(
    (bx - 0.2, (rows - 1) / 2 * dy - 1.4),
    (bx + 0.2, (rows - 1) / 2 * dy - 1.0),
    fill: red.lighten(70%),
    stroke: 0.8pt + red,
  )
  circle((bx - 0.5, (rows - 1) / 2 * dy - 1.2), radius: 0.06, fill: black)
  circle((bx + 0.5, (rows - 1) / 2 * dy - 1.2), radius: 0.06, fill: black)

  // --- Second arrow ---
  let arrow2-x = bx + 1.5
  line(
    (arrow2-x, (rows - 1) / 2 * dy),
    (arrow2-x + 1.5, (rows - 1) / 2 * dy),
    stroke: 1.2pt,
    mark: (end: "stealth", fill: black),
  )

  // --- Right panel: Quantum circuit ---
  let cx = arrow2-x + 3.0
  let nq = 4  // number of qubits
  let wire-len = 4.5

  // Draw qubit wires
  for q in range(nq) {
    line(
      (cx, q * dy),
      (cx + wire-len, q * dy),
      stroke: 0.8pt,
    )
    // qubit label
    content((cx - 0.5, q * dy),
      text(size: 8pt)[$|sigma_#(q + 1) angle.r$])
  }

  // Layer 1: single-qubit gates e^{β*X}
  let g1x = cx + 1.0
  for q in range(nq) {
    rect(
      (g1x - 0.35, q * dy - 0.25),
      (g1x + 0.35, q * dy + 0.25),
      fill: blue.lighten(70%),
      stroke: 0.8pt + blue,
    )
    content((g1x, q * dy),
      text(size: 6pt, fill: blue)[$e^(beta^*_v X)$])
  }

  // Layer 2: two-qubit ZZ gates
  let g2x = cx + 2.8
  for q in range(nq - 1) {
    // Vertical line connecting two qubits
    line(
      (g2x, q * dy),
      (g2x, (q + 1) * dy),
      stroke: 1.0pt + red,
    )
    // Gate box
    rect(
      (g2x - 0.4, (q + 0.5) * dy - 0.25),
      (g2x + 0.4, (q + 0.5) * dy + 0.25),
      fill: red.lighten(70%),
      stroke: 0.8pt + red,
    )
    content((g2x, (q + 0.5) * dy),
      text(size: 6pt, fill: red)[$e^(beta_h Z Z)$])
    // Dots on qubits
    circle((g2x, q * dy), radius: 0.07, fill: red)
    circle((g2x, (q + 1) * dy), radius: 0.07, fill: red)
  }

  // time arrow
  line(
    (cx + wire-len + 0.3, -0.5 * dy),
    (cx + wire-len + 0.3, (nq - 0.5) * dy),
    stroke: 0.6pt,
    mark: (end: "stealth", fill: black),
  )
  content((cx + wire-len + 0.7, (nq - 1) / 2 * dy),
    angle: -90deg, text(size: 8pt)[$"time"$])

  // Circuit label
  content((cx + wire-len / 2, -0.8 * dy),
    text(size: 8pt)[Quantum circuit (one layer = one $T$)])
}

#figure(
  canvas(length: 0.55cm, fig2),
  caption: [Left: tensor network representation of the partition function, with blue tensors ($e^(beta^*_v X)$) on vertical bonds and red tensors ($e^(beta_h Z Z)$) on horizontal bonds. Middle: the two building blocks. Right: the corresponding quantum circuit, where each layer represents one application of the transfer matrix.]
) <fig:tensor-circuit>

#v(0.5em)

== The quantum Hamiltonian

Taking the partition function $Z = tr(T^N)$, the free energy density is

$ f = -frac(1,beta) frac(ln Z,N) = -frac(1,beta) ln lambda_0, $

where $lambda_0$ is the largest eigenvalue of $T$, and the ground-state energy $E_0$ of the quantum Hamiltonian is related to $lambda_0$.

In the limit where the vertical coupling is much stronger than the horizontal one (the _anisotropic_ limit), we can write $T approx e^(-tau hat(H))$ with a small imaginary-time step $tau$, so that

$ hat(H) = -J sum_j hat(Z)_j hat(Z)_(j+1) - h sum_j hat(X)_j, $

which is exactly the 1D transverse-field quantum Ising model. The couplings are related by

$ beta_h arrow J tau, quad beta^*_v arrow h tau. $

This establishes the complete mapping:
#align(center)[
  #rect(
    width: 80%,
    inset: 1em,
    stroke: 0.6pt + black,
  )[
    #align(center)[
    *2D classical Ising model* ($N times L$ square lattice, coupling $K$) \
    $arrow.b.double$ \
    *1+1D quantum Ising model* ($L$ sites, $N$ imaginary-time steps) \
    $ hat(H) = -J sum_j hat(Z)_j hat(Z)_(j+1) - h sum_j hat(X)_j $
    ]
  ]
]

Physical observables are mapped as follows:

- *Free energy* $F = -ln Z = -N ln lambda_0$ corresponds to the ground-state energy $E_0$.
- *Correlation function* $angle.l sigma_i sigma_j angle.r$ in the classical model corresponds to $angle.l hat(Z)_i hat(Z)_j angle.r$ in the quantum model.
- *Phase diagram:* The 2D classical Ising model has a ferromagnetic (FM) to paramagnetic (PM) phase transition at the critical coupling $K_c$. Under the mapping, this corresponds to the quantum phase transition at $(h\/J)_c = 1$ in the transverse-field Ising chain, which is described by the Ising CFT with central charge $c = 1\/2$.

== The anisotropic limit and the phase diagram

In the anisotropic case, the transfer matrix becomes

$ M = e^(beta_v hat(Z)_i hat(Z)_(i+1)) dot e^(beta_h^* hat(X)_j), $

and the Hamiltonian is

$ hat(H) = -J hat(Z) hat(Z) - h hat(X), quad "with" quad h = beta^*_h = 1/2 "arctanh"(e^(-2 beta_h)). $

The self-dual point of the classical model maps to the quantum critical point $h = J$, where the system is described by the Ising CFT. The phase diagram in the $(beta_h, beta_v)$ plane has:

- *Ferromagnetic (FM) phase:* Large $beta_h, beta_v$ $arrow.r$ ordered, $angle.l hat(Z) angle.r eq.not 0$.
- *Paramagnetic (PM) phase:* Small $beta_h, beta_v$ $arrow.r$ disordered, $angle.l hat(Z) angle.r = 0$.
- *Critical line:* The self-dual curve separating the two phases, on which the theory flows to the Ising CFT in the infrared.

// ========== FIGURE 3: Phase diagram ==========
#let fig3 = {
  import draw: *

  // Axes
  line((0, 0), (5.5, 0), stroke: 1pt, mark: (end: "stealth", fill: black))
  line((0, 0), (0, 5.5), stroke: 1pt, mark: (end: "stealth", fill: black))
  content((5.5, -0.4), text(size: 10pt)[$beta_h$])
  content((-0.4, 5.5), text(size: 10pt)[$beta_v$])

  // Critical curve (self-dual line, roughly hyperbolic)
  let pts = ()
  for i in range(0, 41) {
    let t = i / 40.0
    let x = 0.3 + 4.5 * t
    let y = 0.3 + 4.5 * (1.0 - t)
    // Curve it slightly: use a convex shape
    let curve-x = x - 1.2 * t * (1.0 - t)
    let curve-y = y - 1.2 * t * (1.0 - t)
    pts.push((curve-x, curve-y))
  }
  // Draw the critical curve
  for i in range(pts.len() - 1) {
    line(pts.at(i), pts.at(i + 1), stroke: 2pt + blue)
  }

  // FM region label
  content((3.5, 4.2), text(size: 12pt, weight: "bold", fill: red)[FM])

  // PM region label
  content((1.2, 1.2), text(size: 12pt, weight: "bold", fill: rgb("#2196F3"))[PM])

  // Critical line label
  content((1.0, 4.2), text(size: 9pt, fill: blue)[critical line])

  // Self-dual point
  let sdx = 2.1
  let sdy = 2.1
  circle((sdx, sdy), radius: 0.1, fill: black)
  content((sdx + 1.0, sdy - 0.3), text(size: 8pt)[self-dual point \ Ising CFT ($c=1\/2$)])

  // Arrows indicating RG flow (schematic)
  // Into FM
  line((3.8, 3.0), (4.2, 3.8), stroke: 0.6pt, mark: (end: "stealth", fill: gray))
  line((3.0, 3.8), (3.8, 4.5), stroke: 0.6pt, mark: (end: "stealth", fill: gray))
  // Into PM
  line((1.5, 2.0), (0.8, 1.0), stroke: 0.6pt, mark: (end: "stealth", fill: gray))
  line((2.0, 1.5), (1.0, 0.8), stroke: 0.6pt, mark: (end: "stealth", fill: gray))
}

#figure(
  canvas(length: 0.8cm, fig3),
  caption: [Phase diagram of the 2D classical Ising model in the $beta_h$--$beta_v$ plane. The blue curve is the critical (self-dual) line separating the ferromagnetic (FM) and paramagnetic (PM) phases. At the self-dual point, the system is described by the Ising CFT with central charge $c = 1\/2$. Gray arrows indicate schematic RG flow directions.]
) <fig:phase>

== Remarks

- When the interactions include 3-body or higher-body terms, the corresponding quantum model will have multi-qubit gates, leading to a richer structure (e.g., fracton models).

- The transfer matrix approach generalizes to other classical models. For example, the $q$-state Potts model maps to quantum chains with $S U(q)$ symmetry, and the classical $X Y$ model maps to the quantum rotor model.

- The cylindrical geometry (periodic boundary conditions in the spatial direction) of the classical model maps directly to a quantum system on a ring, where the transfer matrix wraps around to form a cylinder in the tensor-network picture. This geometry is particularly natural for extracting the central charge $c$ from finite-size scaling of the free energy.
