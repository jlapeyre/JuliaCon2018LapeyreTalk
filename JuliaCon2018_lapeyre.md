% Symbolic computation in Julia
% John Lapeyre
% JuliaCon 2018, August 11, 2018

# What is Computer algebra / Symbolic computation ?

<!-- \vspace{-1cm} -->
\textcolor{blue}{A didactic dichotomy:}
<!-- \vspace{-1cm} -->

* [AbstractAlgebra.jl](https://nemocas.github.io/AbstractAlgebra.jl/index.html). Algebra is
  [what an "algebraist" does](https://math.stackexchange.com/questions/181220/what-kind-of-work-do-modern-day-algebraists-do).
  Or number theorist, or computational number theorist, or...
  * **Not** symbolic.
  * Organization: language types representing algebraic structures.
  * Optimization: (discrete) numeric efficiency above flexibility.
  * Leader: [Magma](https://en.wikipedia.org/wiki/Magma_(computer_algebra_system)) 1993 (proprietary).
    cited in many publications.

* [Symata.jl](https://github.com/jlapeyre/Symata.jl). Computer algebra is a tool for scientists, engineers.
  * Symbolic: "algebra", calculus, etc. $+$ numbers.
  * Organization: "expressions". Types less important.
  * Optimization: Flexibility, system integration, before efficiency.
  * Leader: Mathematica (proprietary). cited in many publications.

<!-- Symbolic. Organized around "expressions". Flexibility before efficiency. -->
<!-- Mathematica/Wolfram (proprietary) leader. -->

```{.julia}
symata 1> rotheadargs(f_(args__)) :=
          (Last([args])(f, Splat(Most([args]))));
symata 2> rotheadargs(a + b + c + g(x))
Out(2) = g(x)(Plus,a,b,c) # Nonsense ?
```

* Language or library ? C, C++ Lisp, Python, \textcolor{blue}{Julia}

# Comparison / Benchmarks

Polynomial benchmarks -- Fateman-like test

$\vspace{-1.5cm}$

\begin{align*}
f & = x + y + z + 1 \\
p &= f^{20} \\
q &= p * (p + 1) \\
\vspace{-1cm}
\end{align*}

$\vspace{-1.5cm}$

* Polynomial problem one $n = 20$
  * $0.19$ AbstractAlgebra.jl
  * $1.50$  Pari. (not really)
  * $3.80$  SymEngine.jl
  * $7.70$  Mathematica 3
  * $198$  MultivariatePolynomials.jl
  * $490$  SymPy (SymPy, SymPy.jl, ...)
  * $870$  Maxima (GCL) (projected)

```julia
symata 1> FullForm(1 + 3x + 4x^2)
Out(1) = Plus(1,Times(3,x),Times(4,Power(x,2)))
```

# (partial) History of symbolic computation systems

* [Schoonschip](https://en.wikipedia.org/wiki/Schoonschip) *1963 assembly*. Veltman.
  [REDUCE](https://en.wikipedia.org/wiki/Reduce_(computer_algebra_system)) *1965--present lisp-algolish*.
  A. Hearn.

* [Macsyma](https://en.wikipedia.org/wiki/Macsyma) *1968--1992 Lisp*. MIT, Symbolics, DOE. Complicated history.
Changing hardware; OS; personal and organizational goals.

* [Maxima](https://en.wikipedia.org/wiki/Maxima_(software)) *1982--1998--present Common Lisps*. OSS fork of Macsyma.
  Schelter. Now Macsyma people: Fateman, Macrakis, and others.

* Maple *1980-1988--present C core*. Expressions $+$ Algol-like language.
 "An interpreted, untyped, procedural language with lexical scoping and first-class procedures."

* [SMP: Symbolic Manipulation Program](https://en.wikipedia.org/wiki/Symbolic_Manipulation_Program)
  *1979--1981--1988 C core*. Chris. A. Cole and S. Wolfram. Pattern matching and
  expressions. "version 0 of Mathematica". Very popular in CAS research at least by 1984.

<!-- * MuPAD 1997. Pascal-like. Somewhat typed. Bought by MathWorks. -->

# (partial) History of Symbolic computation systems

* Mathematica *1988 C core*. Uniform design. *Everything* is an expression.
  Above all a product. Organizational focus. Extremely assertive marketing, media strategy,
  corporate relations.

* MuPAD *1997 C ?*. Somewhat typed, Algol-like. Subsumed by MATLAB.

* [SageMath](https://en.wikipedia.org/wiki/SageMath) *2005 Everything*. Python interface.

* [SymPy](https://en.wikipedia.org/wiki/SymPy) *2006-present Python*. Library + Python interfaces.
  Expressions and OO classes.

* [Mathics](https://en.wikipedia.org/wiki/SymPy) *????-present Python*. Implementation of Mathematica.
  Backend is SymPy. Expressions. Correct, but slow. Angus Griffith.

* [Symata.jl](https://github.com/jlapeyre/Symata.jl) *2015--present Julia*. SymPy as library.
  Expression-based. Expression-based language. Preceding work:
  MockMma (Fateman). Mixima. Extensions to Maxima.

# Why is there no competitive OSS computer algebra ?

* Competitive means,... viable alternative, has non-negligible market share,

* None. Neither for abstract algebra, nor for symbolic manipulation.

* W. Stein "In 2005 Magma was the only proprietary software on my machines". Same holds
for many scientists with Mathematica.

* Reasons need not be the same. May not be general. GAP, Pari, etc. very narrow. Want CA
in Julia tomorrow ? Support Julia for CRUD today.

* Development "model" or modes. Academy only cares about publications ? Mediocre paper better
than great software. Much smaller use base ? Inherently more difficult minimum viable product ?

# Why is there no competitive OSS computer algebra ?

* SageMath. W Stein. Combine all the best math programs into one competitor to Mma, Maple, Matlab, Magma.
 Very ambitious. What is the design? No funding. 2016 started company.

* 2016 [OSCAR](https://oscar.computeralgebra.de/) "massive transregional grant" for computational mathematics.
 Includes a big project to unify GAP, Singular, Polymake, ANTIC (Flint, Pari ?) using ... \textcolor{blue}{Julia}.
     W. B. Hart and others promoting, using, Julia. Objective (of one part) is to create competitor to Magma.

* Symata. Want functionality of Mathematica, Maple, Maxima.
  Don't want "this pudding has no theme". Mma offers great starting point.
  At least a bit more. A layer in
  Julia offering control over evaluation sequence: easier to get efficiency.


# Julia algebra / symbolic packages

* Number theory and abstract algebra ("algebra" to mathematicians)
  * [AbstractAlgebra.jl](https://nemocas.github.io/AbstractAlgebra.jl/index.html) Fastest!,
    [Nemo.jl](https://github.com/Nemocas/Nemo.jl)
  * [Hecke.jl](https://github.com/thofma/Hecke.jl)
    (Algebraic number theory),
    [Singular.jl](https://github.com/wbhart/Singular.jl)
  * [AlgebraicNumbers.jl](https://github.com/anj1/AlgebraicNumbers.jl) Exact arithmetic
    with algebraic numbers.
  * [SemialgebraicSets.jl](https://github.com/JuliaAlgebra/SemialgebraicSets.jl),
    [SymmetricTensors.jl](https://github.com/ZKSI/SymmetricTensors.jl)

* Polynomials, etc.
  * [Polynomials.jl](https://github.com/JuliaMath/Polynomials.jl),
    [MultivariatePolynomials.jl](https://github.com/JuliaAlgebra/MultivariatePolynomials.jl)

* General purpose
  * [Symata.jl](https://github.com/jlapeyre/Symata.jl)
  * [SymPy.jl](https://github.com/JuliaPy/SymPy.jl)
    SymPy and mpmath,
    [SymEngine.jl](https://github.com/symengine/SymEngine.jl) C++ core.
  * [Reduce.jl](https://github.com/chakravala/Reduce.jl) Interface to Reduce.
  * [Giac.jl](https://github.com/HaraldHofstaetter/Giac.jl)

# Why Now ? Why Julia ?

## Greenspun's oft-appropriated 10th rule

> Any sufficiently complicated symbolic language written in C (or even Java, golang,...), contains an ad-hoc,
> informally-specified, bug-ridden, slow implementation of half of Julia. And forget about the ecosystem.

\textcolor{blue}{Symata \textit{repurposes} features of Julia. Cuts development time!}

* Symbols, Expressions. Syntactic macros. see MacroTools.jl
* Parser. IO of Symata code. Line numbers.
* Memory management, High-performance data structures.
  Type system. \textcolor{blue}{Generic} methods. C-like speed.
* REPL, color, completion, history, multiline editing, modes.
  Notebook, beautiful math.
* Simple language interfaces. Python, C, Fortran.
* Easy, efficient, access to **discrete** and floating point numerics.
* Dev community, mathematicians. Current technology. Forward-thinking. github(lab), CI, Discourse/Slack.

Other options: C, Lisp, Python,... Go ?

# Symata

* Everything is an expression (including atoms). (Mathematica maintains this user-facing semantics, but adds
 heroic optimization.)
 No flow control statements. `For`{.julia}, `If`{.julia} are expression heads.

* Uniform design. Tightly integrated components, builtin functions.

* Expressions traverse the _evaluation sequence_, which transforms them.

* Pattern matching plays central role. Mma designed when AI meant rule-based systems.
  Best integrator: [Rubi](http://www.apmaths.uwo.ca/~arich/) Rule-based Mathematics Symbolic Integration Rules.
  Popularity of [MacroTools.jl](https://github.com/MikeInnes/MacroTools.jl).

<!-- # Symata Examples -->
<!-- blah -->

# Features

## Pattern Matching

Matching is syntactic, ignorant of mathematics.

\textcolor{blue}{associative => Flat, commutative => Orderless}

## Elements

`name_type`, `name__type`, `name___type`,
`Repeated(expr, n)`, `|`, `Except`, Default values.


```julia
countprimes = Count(_`PrimeQ`)
countprimes(Range(100)) --> 25
```

## Consistent features

Levels, "iterators"

## Related

* [Rewrite.jl]( https://github.com/HarrisonGrodin/Rewrite.jl)
* [MacroTools.jl](https://github.com/MikeInnes/MacroTools.jl)

# Simplification function `ExpandSinCos`

```julia
SinRule = Sin(a_ + b__) :>
   Cos(Plus(b)) * Sin(a) + Cos(a) * Sin(Plus(b))
CosRule = Cos(a_ + b__) :>
   Cos(a) * Cos(Plus(b)) - Sin(a) * Sin(Plus(b))
ExpandSinCos(ex_) := ex .\\ [SinRule, CosRule]
```
\textcolor{blue}{Apply this function (or rule)}

```julia
symata 1> ExpandSinCos(1 + Sin(x + y + w*z))

Out(1) = 1 + Cos(x)*(Cos(w*z)*Sin(y) + Cos(y)*Sin(w*z)) +
  (Cos(y)*Cos(w*z) - Sin(y)*Sin(w*z))*Sin(x)
```

<!-- # -->

<!-- ```julia -->
<!-- symata 1> rule = integ(times(x_, delta(y_ - y0_)), -->
<!--     [y_,-Infinity,Infinity]) .> ReplaceAll(x, y => y0); -->

<!-- symata 2> expr = integ(times(Cos(z)*z^2,delta(z - z0)), -->
<!--     [z,-Infinity,Infinity]); -->

<!-- symata 3> ReplaceAll(expr, rule) -->
<!-- Out(3) = z0^2*Cos(z0) -->
<!-- ``` -->

#
\begin{large}\textcolor{magenta}{Mathematica: fourth wall impenetrable.} \end{large}

\begin{large}\textcolor{magenta}{Symata: lots of portals} \end{large}

\textcolor{blue}{Call Julia function from Symata}

$$\vspace{-1cm}$$

```julia
symata 1> J(time)()
Out(1) = 1.533329581480248e9
```

#
```julia
x1 = Range(10.0^3)
y1 = Range(10.0^3)

g(x_, y_) := Module([s=0],
   begin
     For(i=1, i<=Length(x), i += 1,
              s += x[i]^2 / y[i]^(-3)),
     s
   end)

applySum := Apply(Plus, x1^2 / y1^3)
```
```julia
juliaSum = J((x,y) -> sum(u -> u[1]^2 / u[2]^(3),
                       zip(x,y)));
```

\textcolor{blue}{Time}, `g(x1, y1)` : 1, `applySum` : 1/2, `juliaSum(x1, y1)` : 1/20

# Symata

\textcolor{blue}{Generic methods}
```julia
juliaSum = J((x,y) -> sum(u -> u[1]^2 / u[2]^(3),
                       zip(x,y)));
symata 1> juliaSum([a + b, c + d], [u + v, y + z])
```

$$ \vspace{-1.0cm} $$
$$
\begin{aligned}
\hspace{-5cm}\frac{\left( a + b \right) ^{2}}{ \left( u + v \right) ^{3}} + \frac{ \left( c + d \right) ^{2}}{ \left( y + z \right) ^{3}} & \hfill \\
\end{aligned}
$$

# Translate/compile Symata to Julia function

```julia
expr = Collect(Integrate(x^2 * Exp(x) * Cos(x), x),
          Exp(x))
```

$$ \vspace{-0.7cm} $$
$$
e ^{x} \  \left( \frac{- \ \text{Cos} \!  \left( x \right) }{2} + \frac{x^{2} \ \text{Cos} \!  \left( x \right) }{2} + \frac{\text{Sin} \!  \left( x \right) }{2} + \frac{x^{2} \ \text{Sin} \!  \left( x \right) }{2} \ - \ x \ \text{Sin} \!  \left( x \right)  \right)
$$
```julia
cexpr = Compile([x], Evaluate(expr));
native_julia(x) = exp(x)*((-1/2)*cos(x) + (1/2)*x^2*cos(x) 
  + (1/2)*sin(x) + (1/2)*x^2*sin(x) - x*sin(x))
```
```julia
> @btime ccexpr(2.0)  ==>  56 ns
> @btime native_julia(2.0) ==> 56 ns
> ccexpr(:y)
E^y*((-1/2)*Cos(y) + (1/2)*y^2*Cos(y) +
(1/2)*Sin(y) + (1/2)*y^2*Sin(y) - y*Sin(y))
```

# Translate/compile Symata to Julia function

\textcolor{blue}{Wrap Symata expression in Julia function}
```julia
symata 1> symzeta = SymataCall([x], Zeta(x));
symata 2> ExportJ(symzeta)
julia> symzeta(4)
(1//90)*:Pi^4
```

\textcolor{blue}{Compile Symata to Julia}

```julia
symata 1> hypot = Compile([x, y], Sqrt(x^2 + y^2));
symata 2> hypot(3, 4)
Out(2) = 5
```

\textcolor{blue}{Why is the hypotenuse exact ?}
```julia
symata 3> ToJuliaString(Sqrt(x^2 + y^2),
                        NoSymata => False)
Out(4) = "mpow(mplus(mpow(x, 2), mpow(y, 2)), 1//2)"
```

<!-- # -->
<!-- \textcolor{blue}{Do we pay a penalty for using  mmul ?} -->
<!-- ```julia -->
<!-- julia> @btime 2 * 3 -->
<!--   0.015 ns (0 allocations: 0 bytes) -->
<!-- 6 -->
<!-- julia> @btime mmul(2, 3) -->
<!--   0.014 ns (0 allocations: 0 bytes) -->
<!-- 6 -->
<!-- julia> @btime mmul(:a, :b) -->
<!--   2.198 micro s (9 allocations: 720 bytes) -->
<!-- :a*:b -->

<!-- julia> @btime cos(.5); -->
<!-- 1.535 ns (0 allocations: 0 bytes) -->
<!-- julia> @btime Cos(.5); -->
<!-- 1.536 ns (0 allocations: 0 bytes) -->
<!-- julia> @btime Cos(Pi) -->
<!-- 24.984 micro s (41 allocations: 1.70 KiB) -->
<!-- -1 -->
<!-- ``` -->

# SymPy

* SymPy. mpmath moved to stand alone. both pure Python.

* Python slow, not suited for expression-based language.

* Not prematurely optimized. Great sucess. \textcolor{blue}{Relatively complete}. Often fast enough.

* Essentially a library. For free: tested/optimized language; huge ecosystem;
  interactive UIs.

* Design. Symbolic expressions. Mainly standard Python (heavily) OO approach.
  Not suitable for people who want a super calculator.
  
# When would you use (or not) Symata ?

* Mma. Often used because a student was introducd to it early.

* Super-calculator. Simple programming.

* Prototyping. (L Shifrin)

* Can be very slow, even Mma, after lots of years and dollars.

* *Julia* may be a substitute for special purpose "symbolic" or discrete
problems. (Jesse [tiling], Jared [Dirac notation], and ...)

* Completeness in domains. Want lots of special functions, high precision, complex ?
(E.g. inverse Laplace transform). Integrate exotic integrands over exotic domains.

* Most likely will want to break out of the expression/evaluation model.

#

\begin{centering} 
\hfill \Huge{Thank you!} \hfill
\end{centering}

<!--  LocalWords:  Fortran numerics MATLAB Scilab cython Haskell BTA
 -->
<!--  LocalWords:  julia riccati cn cond isfinite webpage PyCall APIs
 -->
<!--  LocalWords:  metaprogramming Coroutines UTF eg JIT inlining OMP
 -->
<!--  LocalWords:  homoiconic github Filesystem builtin OO Voronoi im
 -->
<!--  LocalWords:  const num onewalk randbool println STDERR imag BSC
 -->
<!--  LocalWords:  Lapeyre Bezanson Karpinski Edelman Matlab Rubyists
 -->
<!--  LocalWords:  Pythonistas Mathematica PDL perl JL matlab cpython
 -->
<!--  LocalWords:  datafile jython numpy numba pypy pyston Dev KMOD
 -->
<!--  LocalWords:  Modzelewski webserver webservers ize PyPy LOC JS
 -->
<!--  LocalWords:  codebase Lua isinstance jl polymorphism UInt GMP
 -->
<!--  LocalWords:  LinAlg linalg xs FFTW BLAS Greenspun's hoc SciPy
 -->
<!--  LocalWords:  DSLs Multiline repl Jypyter repo struct Jameson th
 -->
<!--  LocalWords:  whoAmI uniqueFunctionA uniqueFunctionB ccall libc
 -->
<!--  LocalWords:  pyimport mpmath ellip ellipe ellipf ellipfun ribot
 -->
<!--  LocalWords:  ellipk ellippi elliprc elliprd elliprf elliprg RNG
 -->
<!--  LocalWords:  elliprj rwtest cpp Mersenne pdf displacments Bool
 -->
<!--  LocalWords:  gcc RNG's AbstractAlgebra algebraist Symata symata
 -->
<!--  LocalWords:  rotheadargs args Schoonschip Macsyma Symbolics OSS
 -->
<!--  LocalWords:  untyped SMP matcher MuPAD MathWorks SageMath SymPy
 -->
<!--  LocalWords:  Nemo Hecke AlgebraicNumbers SemialgebraicSets Giac
 -->
<!--  LocalWords:  SymmetricTensors MultivariatePolynomials SymEngine
 -->
<!--  LocalWords:  golang textcolor textit repurposes MacroTools Mma
 -->
<!--  LocalWords:  multiline FullForm Rubi Orderless ExpandSinCos ns
 -->
<!--  LocalWords:  ExpandSinRule ExpandCosRule ReplaceRepeated integ
 -->
<!--  LocalWords:  ReplaceAll expr vspace applySum juliaSum hspace
 -->
<!--  LocalWords:  frac hfill symzeta SymataCall ExportJ hypot Sqrt
 -->
<!--  LocalWords:  ToJuliaString NoSymata mpow mplus mmul btime KiB
 -->
<!--  LocalWords:  sucess UIs sympy sym ExpToTrig Sinh jit algolish
 -->
<!--  LocalWords:  CAS
 -->
