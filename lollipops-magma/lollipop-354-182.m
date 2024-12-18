clear;

D:=11984649;
x:=148050398434362621716956241060772527011598270495837764; 
assert x mod 12 eq 4;
p:=x^2-x+1;
q:=x^2+1;
assert IsPrime(p: Proof:=false);
assert IsPrime(q: Proof:=false);
Fp:=GF(p);
Fq:=GF(q);

////////////////////////////////////////////////////////////
//Construct Ecalhat
////////////////////////////////////////////////////////////
Fq3:=ExtensionField<Fq,x|IrreduciblePolynomial(Fq,3)>;
Ecalhat:=BaseChange(EllipticCurve([Fq|0,1]),Fq3);
assert #Ecalhat eq (q^3+1);
assert (q^3+1) mod p eq 0;

////////////////////////////////////////////////////////////
//Construct Ecal
////////////////////////////////////////////////////////////
Fp2<mu>:=ExtensionField<Fp,x|x^2+2>;
Fp4<nu>:=ExtensionField<Fp2,x|x^2-mu>;
//Broker's algorithm
bCalhat:=(3152415216999630016732418800721053616328491327804020801096030843594467566828731132616477379978861940189707*mu +
        14245305942739993852001953773900562503245113129119846849067379843841259716215668949675914443640885052778731)*nu +
        6569369186549766455411303531845877085214372573360227453768878754416675324178837091878540259806079037132996*mu +
        20678878790494399350323129246378587457019906866527909675667431542335931906028698588394413166980916454814935;
aCalhat:= (5289535699640842410731481012244074569738276372875743386365004776931511852990042292849627022126739144285546*mu +
        18687002469823254447746833679231452066780836870778916750722535301389495776527790011402013337237143846871838)*nu +
        21227743127116372695909786163571369378417286024520070536716507925502815671917400333956773553520823186680033*mu +
        7054000215265825127520334112166075207875017286871801935479388571085856439311131439034407583261088223692518;
Ecal:=EllipticCurve([Fp4|aCalhat,bCalhat]);
assert (p^2+1)^2*Random(Ecal) eq Ecal!0;

////////////////////////////////////////////////////////////
//Construct E
////////////////////////////////////////////////////////////

//jp is a root of Hilbert Class Polynomial H_D(X) in Fp[X]
//jp:=2095023966015544490556902790497295852753211652590001306210415971724520453272081526891907899642031043119124;
//Ep:=EllipticCurveFromjInvariant(Fp!jp);
Ap:=4931272734379042324546627480672493946953186816541191713263611070456748753276694059968624305544115165244531;
Bp:=19608082442390837172006958228408170889581692634239486750940142603497561667995754919945528028710941699718166;
E:=EllipticCurve([Fp|Ap,Bp]);
h:=5834265205101705653173060000604386256798782198769690;
r:=3756929057219883666227531396958400808844831162374992793;
assert IsPrime(r: Proof:=false);
N:=h*r;
assert N*Random(E) eq E!0;
assert Evaluate(CyclotomicPolynomial(4),p) mod r eq 0; 

////////////////////////////////////////////////////////////
//Construct Ebold and Eboldhat: D=-18403
////////////////////////////////////////////////////////////
Fr:=GF(r);
rhat:=3756929057219883666227531398672325357531137771763150651;
assert IsPrime(rhat: Proof:=false);
Frhat:=GF(rhat);

abold:= 2113378115523827708306635672960741373816143934973649948;
bbold:=3287101883392111915841791447995318870057374454802685690;
Ebold:=EllipticCurve([Fr|abold,bbold]);
aboldhat:=1355922423682260700378649141390678330573347616240158723;
bboldhat:=1045084209855362265470233115890968696384442539282833205;
Eboldhat:=EllipticCurve([Frhat|aboldhat,bboldhat]);

assert r*Random(Eboldhat) eq Eboldhat!0;
assert rhat*Random(Ebold) eq Ebold!0;

////////////////////////////////////////////////////////////
//Construct Ebold_W
////////////////////////////////////////////////////////////
b:=7906;
Ebold_W:=EllipticCurve([Fr|-3,b]);
N_W:=3756929057219883666227531398355970043571314463948004619;
Ebold_Wt:=QuadraticTwist(Ebold_W);
N_Wt:=3756929057219883666227531395560831574118347860801980969;
assert IsPrime(N_W: Proof:=false);
assert IsPrime(N_Wt: Proof:=false);
assert N_W*Random(Ebold_W) eq Ebold_W!0;
assert N_Wt*Random(Ebold_Wt) eq Ebold_Wt!0;

////////////////////////////////////////////////////////////
//Construct Ebold_Ed
////////////////////////////////////////////////////////////
d:=2758;
AS<X,Y>:=AffineSpace(Fr,2);
Ebold_Ed:=Curve(AS,-X^2+Y^2-(1+d*X^2*Y^2));
E_Ed:=EllipticCurve(ProjectiveClosure(Ebold_Ed),Ebold_Ed![0,1]);
r_Ed:=469616132152485458278441424265440778940645065979380779;
E_Edt:=QuadraticTwist(E_Ed);
r_Edt:=939232264304970916556882849948318846541125449228734839;
assert IsPrime(r_Ed: Proof:=false);
assert IsPrime(r_Edt: Proof:=false);
N_Ed:=2^2*r_Ed;
N_Edt:=2^3*r_Edt;
assert N_Ed*Random(E_Ed) eq E_Ed!0;
assert N_Edt*Random(E_Edt) eq E_Edt!0;
