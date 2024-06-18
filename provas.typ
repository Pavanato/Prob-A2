#import "theorems.typ": *
#show: thmrules.with(qed-symbol: $square$)

// #set page(margin: 1.5cm)
#set text(font: "Linux Libertine", lang: "pt")
#set heading(numbering: "1.")

#let theorem = thmbox("teorema", "Teorema", fill: rgb("#eeffee"))
#let corollary = thmbox(
  "Corolário",
  "Corolário",
  base: "teorema",
  fill: rgb("#f8e8e8"),
  titlefmt: strong
)
#let definition = thmbox(
  "definição", 
  "Definição", 
  // inset: (x: 1.2em, top: 1em),
  fill: rgb("#e7e7e7")
  )

#let example = thmplain("exemplo", "Exemplo").with(numbering: none)
#let proof = thmproof("prova", "Prova", titlefmt: strong)

#set heading(numbering: (..nums) => {
  let (part, ..chapter_and_sections) = nums.pos()

  if chapter_and_sections.len() == 0 {
    [Capítulo #part.]
  }
  else {
    let (section, ..subsections) = chapter_and_sections

    if subsections.len() == 0 {
      [Seção #part.#section.]
    } else {
      numbering("1.", part, section, ..subsections)
    }
  }
}
)

#context counter(heading).update(4)

= 
#context counter(heading).update((5,3))

#theorem("Universalidade da Uniforme")[Seja $F$ uma CDF, uma função contínua e estritramente crescente no suporte da distribuição. Isto garante que a função inversa $F^(-1)$ existe e é única, onde $F^(-1): (0,1) -> RR$. Os seguintes resultados valem:

+ Seja $U tilde "Unif"(0,1)$ e $X = F^(-1)(U)$. Então, $X$ é uma v.a. com CDF $F$.
+ Seja $X$ uma v.a. com CDF $F$. Então, $F(X) tilde "Unif"(0,1)$.
]

#proof[
  + Tomando $X = F^(-1)(U)$, temos que $ P(X <= x) = P(F^(-1)(U) <= x) = P(U <= F(x)) = F(x). $ 

  + Seja $U = F(X)$, então $ P(U <= u) = P(F(X) <= u) = P(X <= F^(-1)(u)) = F(F^(-1)(u)) = u. $
]<universal>


=

Vazio por hora

=

#theorem(number: "7.1.20")[Seja $f_(x y)$ a PDF conjunta de $X$ e $Y$ tal que

$ f_(x y)(x,y) = g(x)h(y) $

para todo $x$ e $y$, onde $g(x)$ e $h(y)$ são funções não negativas. Então $X$ e $Y$ são independentes. Se $g$ ou $h$ for uma PDF válida, então a outra também é, e a PDF conjunta é o produto das marginais.
]

#proof[defina

$ c = integral_(- infinity)^(infinity)h(y)d y > 0 $

podemos reescrever a PDF conjunta como

$ f_(x y)(x,y) = g(x)h(y) = c g(x)(h(y))/c $

então a PDF marginal de $X$ é

$ f_X = integral_(- infinity)^(infinity)f_(x y)(x,y)d y = integral_(- infinity)^(infinity)c g(x)(h(y))/c d y = c g(x)integral_(- infinity)^(infinity)(h(y))/c d y = c g(x). $

Segue que $integral_(- infinity)^(infinity)g(x)d x = 1$ já que $f_X$ é uma PDF válida. Analogamente, $(h(y))/c$ é a PDf marginal de $Y$. Portanto, $c g(x)$ e $(h(y))/c$ são PDFs válidas, o que conclui que $X$ e $Y$ são independentes.]


















#pagebreak()

#set heading(numbering: "1.")

= Desigualdades

#theorem("Desigualdade de Markov")[
Seja $X$ uma variável aleatória não negativa. Então, para todo $a > 0$,

$ P(|X| >= a) <= (E(|X|))/a $
]

#proof[Seja $Y = (|X|)/a$ e $I_(Y >= 1)$ a função indicadora de $Y >= 1$. Temos que $I_(Y >= 1) = 1 <=> Y >= 1$ e $I_(Y >= 1) = 0 <=> Y < 1$. Isso implica que $I_(Y >= 1) <= Y$. Logo, aplicando a esperança em ambos os lados, temos

$
    E(I_(Y >= 1)) <= E(Y) => P(Y >= 1) <= E(Y) => P((|X|)/a >= 1) <= E((|X|)/a) => P(X >= a) <= (E(|X|))/a
$
]



#let Var(X) = $"Var"(X)$

#theorem("Desigualdade de Chebyshev")[
Seja $X$ uma variável aleatória com média $mu$ e variância $sigma^2$. Então, para todo $a > 0$,

$ P(|X - mu| >= a) <= (sigma^2)/(a^2) $
]

#proof[Seja $Y = |X - mu|^2$, com isso temos

$ P(|X - mu| >= a) = P(|X - mu|^2 >= a^2) = P(Y >= a^2) $

Aplicando a desigualdade de Markov, temos

$ P(Y >= a^2) <= E(Y)/a^2 = E(|X - mu|^2)/a^2 = (sigma^2)/a^2 $

Portanto

$ P(|X - mu| >= a) <= (sigma^2)/(a^2) $
]

#theorem("Desigualdade de Chernoff")[
Seja $X$ uma variável aleatória com média $mu$. Então, para todo $a > 0$,

$ P(X >= mu + a) <= e^(-t a) M_X(t) = E(e^(t X))/e^(t a) $

onde $M_X(t)$ é a função geradora de momentos de $X$.
]

#proof[Seja $Y = e^(t X)$, com isso temos

$ P(X >= a) = P(e^(t X) >= e^(t a)) = P(Y >= e^(t a)) $

Aplicando a desigualdade de Markov, temos

$ P(Y >= e^(t a)) <= E(Y)/e^(t a) = E(e^(t X))/e^(t a) $

Portanto

$ P(X >= a) <= e^(-t a) M_X(t) = E(e^(t X))/e^(t a) $
]

#definition("convexidade e concavidade")[Seja $g$ uma função duas vezes diferenciável. Dizemos que $g$ é convexa se $g''(x) >= 0$ para todo $x$ e concava se $g''(x) <= 0$ para todo $x$.]
  
#theorem("Desigualdade de Jensen")[ Seja $X$ uma variável aleatória e $g$ uma função convexa, então

$ g(E(X)) <= E(g(X)) $

Se $g$ é concava, a desigualdade é invertida, ou seja,

$ g(E(X)) >= E(g(X)) $

onde a igualdade vale se, e somente se, $g(X) = a + b X$ com probabilidade 1.
]

#proof[ Se $g$ é convexa, então $g''(x) >= 0$ para todo $x$. E seja $a + b X$ a reta tangente a $g$ em $E(X)$, então temos

$ g(X) >= a + b X $

aplicando a esperança em ambos os lados, temos

$ E(g(X)) >= a + b E(X) = g(E(X)) $

Onde a igualdade vale pois a reta é tangente em $E(X)$. 

Usando a mesma $g$, temos que $h = -g$ é concava, usando a desigualdade encontrada acima, temos

$ E(-h(X)) >= -h(E(X)) ==> -E(h(X)) >= -h(E(X)) $

multiplicando por $-1$ em ambos os lados, temos

$ E(h(X)) <= h(E(X)) $



]