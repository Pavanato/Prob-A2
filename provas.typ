#import "theorems.typ": *
#show: thmrules.with(qed-symbol: $square$)

#set page(numbering: "1")

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

#let var = $op("Var")$


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

#theorem("Propriedades da Normal", numbering: none)[Seja $Z ~ text(N)(0,1)$ com PDF $phi(z)$ e CDF $Phi(z)$. Então, as seguintes propriedades valem:
  
- Simetria: $phi(z) = phi(-z)$
- Simetria das caudas: $Phi(z) = 1 - Phi(-z)$
- Simetria entre Z e -Z: $Phi_(-Z)(z) = Phi_(Z)(z)$
]

#proof[
  - A simetria é trivial, pois $phi(z) = (1/sqrt(2 pi))e^(-z^2/2) = (1/sqrt(2 pi))e^(-(-z)^2/2) = phi(-z)$.

  - A simetria das caudas é dada por $Phi(z) = integral_(- infinity)^(z)phi(t) d t = integral_(- infinity)^(z)phi(-t)d t = - integral_(infinity)^(-z)phi(u)d u = integral_(-z)^(infinity)phi(u)d u =1 - integral_(-infinity)^(-z)phi(u)d u = 1 - Phi(-z)$. 

  - A simetria entre $Z$ e $-Z$ é dada por $Phi_(-Z)(z) = P(-Z <= z) = P(Z >= -z) = 1 - P(Z <= -z) = 1 - Phi(-z) = Phi(z)$.
]

#definition(number: "5.5.2", "Propriedade da não memória")[ Dizemos que uma v.a. $X$ tem a propriedade da não memória se, para todo $s, t > 0$, vale

$ P(X > s + t | X > s) = P(X > t) $
]

Note que se $X ~ text("Expo")(lambda) $, então $X$ tem a propriedade da não memória. Pois

$ P(X > s + t | X > s) = P((X > s + t) sect (X > s))/P(X > s) = P(X > s + t)/P(X > s) = e^(-lambda(s + t))/e^(-lambda s) = e^(-lambda t) = P(X > t) $

#theorem(number: "5.5.3")[Se $X$ é uma v.a. contínua com a propriedade da não memória, então $X$ é uma v.a. exponencial.]

#proof(title: "Prova 1")[Seja $F$ a CDF de $X$ e $G(x) = P(X > x) = 1 - F(x)$. Pela propriedade da não memória, temos

$ G(s+t) = G(s)G(t) $

pois $G(s+t) = P(X > s + t) = P(X > s + t | X > s)P(X > s) = P(X > t)P(X > s) = G(t)G(s)$, a segunda igualdade decorre da lei da probabilidade total e de que $P(X > s + t | X <= s) = 0$. Diferenciando em relação a $s$, temos

$ G'(s + t) = G'(s)G(t) $

e quando $s = 0$ 

$ G'(t) = G'(0)G(t) $

resolvendo a equação diferencial, temos

$ G(t) = K e^(-lambda t) $

onde $lambda = -G'(0)$, e $K = G(0) = 1$. Portanto, $X ~ text("Expo")(lambda)$.]

#proof(title: "Prova 2")[Usando o resultado da *prova 1:* $G(s+t) = G(s)G(t)$, podemos mostrar que $G$ é uma função exponencial. Note que $G(0) = 1$, pois

$ G(0) = G(0 + 0) = G(0)G(0) = G(0)^2 $

E se $G(0) = 0$, então $G(t) = 0$ para todo $t$, o que é absurdo, pois $G(t) = P(X > t)$. Portanto, $G(0) = 1$. Podemos encontrar $G(2)$ da seguinte forma

$ G(2) = G(1 + 1) = G(1)G(1) = G(1)^2 $

De forma similar $G(3)$ é

$ G(3) = G(1 + 2) = G(1)G(2) = G(1)G(1)^2 = G(1)^3 $

podemos provar por indução que $G(n) = G(1)^n$, para $n$ inteiro positivo da seguinte forma

$ G(n) = G(1)^n $

$ G(n + 1) = G(n)G(1) = G(1)^n G(1) = G(1)^(n+1). $

Queremos estender essa propriedade para $n$ racional, para isso observe que 

$ G(1) = G(underbrace(1/n + dots +1/n, "n termos")), $

então

$ G(1) = G(1/n)G(1/n) dots G(1/n) = G(1/n)^n $

e portanto

$ G(1/n) = G(1)^(1/n) $

e para $m$ inteiro positivo, temos

$ G(m/n) = G(underbrace(1/n + dots + 1/n, "m termos")) = G(1/n) dots G(1/n) = G(1/n)^m = G(1)^(m/n) $

A extensão para $x$ real positivo vem com a pré requesito de um entendimento de análise real, portanto não será feito aqui. Portanto, $G(x) = G(1)^x$. Por fim, observe que

$ G(x) = G(1)^x = e^(ln (G(1)^x)) = e^(x ln (G(1))) $

Chamando $lambda = - ln (G(1))$, temos que $G(x) = e^(-lambda x)$, ou seja, $X ~ text("Expo")(lambda)$.]



=

#theorem("Caiu no teste uma parte", number: "6.1.4")[Seja $X$ uma v.a. com média $mu$ e mediana $m$. Então

- O valor $c$ que minimiza $E(X - t)^2$ é $t = mu$.
- O valor $c$ que minimiza $E|X - t|$ é $t = m$.
]<test>

#proof[Seja $f(t) = E(X - t)^2 = E(X^2 - 2 X t + t^2) = E(X^2) - 2 t E(X) + t^2$. Derivando em relação a $t$, temos

$ f'(t) = -2 E(X) + 2 t $

e igualando a zero concluímos que

$ -2 E(X) + 2 t = 0 => t = E(X) = mu. $

Já para $f(t) = E|X - t|$, não podemos derivar diretamente. Portanto, vamos provar que $E|X - t| >= E|X - m|$ para todo $t$. Podemos simplificar o problema da seguinte maneira

$ E|X - t| >= E|X - m| ==> E(|X - t| - |X - m|) >= 0. $


Assuma que $t > m$ (o caso $t < m$ é similar). Então, para $X <= m$ temos 

$ |X - t| - |X - m| = -(X - t) -(m - X) = t - m, $

e se $X > m$ temos

$ |X - t| - |X - m| = X - t - (X - m) = m - t. $

Seja $Y = |X - t| - |X - m|$, então, pela lei da esperança total, temos

$ E(Y) &= E(Y | X <= m)P(X <= m) + E(Y | X > m)P(X > m) \
&= E(t - m | X <= m)P(X <= m) + E(m - t | X > m)P(X > m) \
&= (t - m)P(X <= m) + (m - t)P(X > m) \
&= (t - m)P(X <= m) - (t - m)(1 - P(X <= m)) \
&= 2(t - m)P(X <= m) - (t - m) = (t - m)(2P(X <= m) - 1). 
$

Como $P(X <= m) >= 1/2$, temos que $2P(X <= m) - 1 >= 0$, e portanto $E(Y) >= 0$. Concluindo que $E|X - t| >= E|X - m|$ para todo $t$.]



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






#theorem("independente implica corr = 0", number: "7.3.2")[Sejam $X$ e $Y$ v.a. independentes. Então, $"corr"(X,Y) = 0$.]
  

#proof[Como a fórmula da correlação é

$ "corr"(X,Y) = "cov"(X,Y)/(sqrt("var"(X)"var"(Y))) $

Basta mostrar que a covariância é zero. Como $X$ e $Y$ são independentes, temos que

$ "cov"(X,Y) = E(X Y) - E(X)E(Y) = E(X)E(Y) - E(X)E(Y) = 0 $

e a prova de que $E(X Y) = E(X)E(Y)$ é, no caso contínuo,

$ E(X Y) &= integral_(- infinity)^(infinity)integral_(- infinity)^(infinity)x y f_(x y)(x,y)d x d y  \ &= integral_(- infinity)^(infinity)integral_(- infinity)^(infinity)x y f_X(x)f_Y(y)d x d y \ &= integral_(- infinity)^(infinity)x f_X(x)d x integral_(- infinity)^(infinity)y f_Y(y)d y = E(X)E(Y) $

E no caso discreto

$ E(X Y) &= sum_(x)sum_(y)x y f_(x y)(x,y) \ &= sum_(x)sum_(y)x y f_X(x)f_Y(y) \ &= sum_(x)x f_X(x)sum_(y)y f_Y(y) = E(X)E(Y) $
]

*Observação:* A recíproca não é verdadeira, ou seja, $"corr"(X, Y) = 0$ não implica independência. 

#theorem(number: "7.5.2")[Dentro de uma distribuição normal multivariada (MVN), não correlacionadas implica independência. Ou seja, se $bold(X) tilde (bold(X)_1, bold(X)_2)$, onde $bold(X)_1$ e $bold(X)_2$ são subvetores de $bold(X)$, e $"corr"(bold(X)_1, bold(X)_2) = 0$, então $bold(X)_1$ e $bold(X)_2$ são independentes.]

#proof[A prova será feita para o caso bivariado, onde a prova em maiores dimensões é análoga. Seja $bold(X) = (X, Y)$, onde $W = s X + t Y$ é uma normal univariada para todo $s, t$. Lembrando que a MGF de uma normal é

$ M_W (t_1, ..., t_n) = exp(t_1 E(X_1) + ... + t_k E(X_k) + 1/2 var(t_1 X_1 + ... + t_k X_k)) $

Então, a MGF de $W$ é

$ M_W (s, t) = exp(s E(X) + t E(Y) + 1/2 var(s X + t Y)) $

Chamando $E(X) = mu_X$, $E(Y) = mu_Y$, $var(X) = sigma_X^2$, $var(Y) = sigma_Y^2$ e $"corr"(X, Y) = rho$, temos

$ M_W (s, t) = exp(s mu_X + t mu_Y + 1/2 (s^2 sigma_X^2 + t^2 sigma_Y^2 + 2 s t rho sigma_X sigma_Y)) $

Se $rho = 0$, então

$ M_W (s, t) &= exp(s mu_X + t mu_Y + 1/2 (s^2 sigma_X^2 + t^2 sigma_Y^2)) \ &=exp(s mu_X + 1/2 s^2 sigma_X^2) exp(t mu_Y + 1/2 t^2 sigma_Y^2) $

Porém isto é a MGF de $X$ e $Y$ separadamente, o que implica que $X$ e $Y$ são independentes. Portanto, $"corr"(X, Y) = 0$ implica independência (em multivariadas)]

=

#theorem("Convolução", number: "8.2.1")[ Sejam $X$ e $Y$ v.a.s independentes discretas, então a PMF da sua soma $T = X+Y$ é

$ P(T = t) = sum_x P(Y = t - x)P(X = x) $
$ P(T = t) = sum_y P(X = t - y)P(Y = y) $

E para o caso contínuo, a PDF da soma é

$ f_T(t) = integral_(- infinity)^(infinity)f_Y (t - x)f_X (x)d x $
$ f_T(t) = integral_(- infinity)^(infinity)f_X (t - y)f_Y (y)d y $
]

#proof[Para o caso discreto, temos

$ P(T = t) = P(X + Y = t) attach(=, t: "LOTP")& sum_(x)P(X + Y = t|X = x)P(X = x) \
=& sum_(x) P(Y = t - x|X=x)P(X = x) \
=& sum_(x)P(Y = t - x)P(X = x) 
$

De forma análoga, pode-se provar para $P(T = t) = sum_y P(X = t - y)P(Y = y)$.

Note que a terceira igualdade é verdadeira pois $X$ e $Y$ são independentes. Para o caso contínuo:

$ f_T(t) = P(T <= t) =& P(X + Y <= t)  \ attach(=, t: "LOTP") &integral_(- infinity)^(infinity)P(X + Y <= t|X = x)f_X (x)d x \
=& integral_(- infinity)^(infinity)P(Y <= t - x)f_X (x)d x \
=& integral_(- infinity)^(infinity)f_Y (t - x)f_X (x)d x
$

Analogamente para $f_T(t) = integral_(- infinity)^(infinity)f_X (t - y)f_Y (y)d y$.]

#theorem(number: "8.4.3", "Gamma = soma expo")[ Sejam $X_1, dots, X_n$ v.a.s independentes com $X_i tilde text("Expo")(lambda)$. Então 

$ X_1 + dots + X_2 tilde "Gamma"(n, lambda) $
]

#proof[A MGF de $X_i$ é $M(t) = lambda/(lambda-t)$, então a MGF da soma é

$ M_(X_1 + dots + X_n)(t) = M_(X_1)(t) times dots times M_(X_n)(t) = (lambda/(lambda-t))^n $

Para $t < lambda$. Seja $Y tilde "Gamma"(n, lambda)$, então a MGF de $Y$ é

$ M_Y (t) = E(e^(t Y)) &=  integral_0^(infinity) 1/Gamma(n) e^(t y) (lambda y)^(n)e^(-lambda y) (d y)/y \
&= lambda^n integral_0^(infinity) 1/Gamma(n) y^(n)e^(-(lambda - t) y) (d y)/y \
&= (lambda^n)/(lambda - t)^n integral_0^(infinity) 1/Gamma(n) ((lambda - t)y)^(n)e^(-(lambda - t) y) (d y)/y \
&= (lambda^n)/(lambda - t)^n 
$

Na segunda igualdade apenas foi retirado o $lambda^n$ da integral. E na terceira foi multiplicado e dividido por $(lambda - t)^n$ e nota-se que a integral restante é a PDF de uma v.a. $"Gamma"(n, lambda - t)$. Portanto, comos as MGFs são iguais, temos que $X_1 + dots + X_n tilde "Gamma"(n, lambda)$.]

=

#context counter(heading).update((9,1,4))

#theorem(number: "9.1.5", "lei da esperança total")[Seja $A_1, dots, A_n$ uma partição do espaço amostral, onde $P(A_i) > 0$ para todo $i$, e $X$ uma v.a. Então

$ E(X) = sum_(i = 1)^(n)E(X|A_i)P(A_i) $
]

#proof[Pelo *Teorema 9.3.7* (Lei de Adão), temos que

$ E(E(X|Y)) &= E(X) $

Considerando $Y$ uma v.a. discreta, e $g(y) = E(X|Y = y)$, então

$ E(E(X|Y)) = E(g(Y)) = sum_y g(y)P(Y = y) = sum_y E(X|Y = y) P(Y = y)
$

Fazendo a relação $A_i = {Y = i}$, temos

$ E(E(X|Y)) = sum_y E(X|Y = y) P(Y = y) = sum_(i = 1)^(n) E(X|A_i)P(A_i) = E(X) $

Portanto, $E(X) = sum_(i = 1)^(n)E(X|A_i)P(A_i)$. Para o caso contínuo, a prova é análoga.]



#theorem(number: "9.3.7", "Lei de Adão")[ Para quaisquer v.a.s $X$ e $Y$ vale

$ E(E(Y|X)) = E(Y) $
]

#proof[Para $X$ e $Y$ discretas e $g(X) = E(Y|X)$, temos

 $ E(g(X)) &= sum_x g(x)P(X=x) \
  &= sum_x E(Y|X=x)P(X=x) \
  &= sum_x (sum_y y P(Y=y|X=x))P(X=x) \
 $

 Lembre-se que $P(A sect B) = P(A|B)P(B)$, então

  $ E(g(X)) &= sum_x sum_y y P(Y=y|X=x)P(X=x) \
    &= sum_y y sum_x P(Y=y sect X=x) \
    &= sum_y y P(Y=y) = E(Y) $
  
    Portanto, $E(E(Y|X)) = E(Y)$. Para o caso contínuo, a prova é análoga.]


#theorem("Lei de Eva", number: "9.5.4")[Para quaisquer v.a.s $X$ e $Y$ vale

$ var(Y) = E(var(Y|X)) + var(E(Y|X)) $

O nome da lei vem de que a ordem de esperanças e variâncias é $"EVVE"$, onde em inglês $"EVE"$ é o nome de Eva.
]

#proof[Seja $g(X) = E(Y|X)$, então pela lei de Adão $E(Y) = E(E(Y|X)) = E(g(X))$. Então

$ E(var(Y|X)) &= E(E(Y^2|X) - E(Y|X)^2) \ &= E(E(Y^2|X)) - E(E(Y|X))^2 \ 
    &= E(Y^2) - E(g(X))^2 $

  e

$ var(E(Y|X)) &= var(g(X)) \ &= E(g(X)^2) - E(g(X))^2 \ 
  &= E(g(X)^2) - E(Y)^2 $

  Por fim, somando as duas equações, temos

$ E(var(Y|X)) + var(E(Y|X)) &= E(Y^2) - E(g(X))^2 + E(g(X)^2) - E(Y)^2 \ &= E(Y^2) - E(Y)^2 = var(Y) $
]



=
vazio por hora


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

$ P(X >= a) <= e^(-t a) M_X(t) = E(e^(t X))/e^(t a) $

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

