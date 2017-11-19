module ClassPolynomials

import Nemo, GZip

DIR = Pkg.dir("ClassPolynomials", "deps")

export ClassicalModularPolynomial, AtkinModularPolynomial, EtaModularPolynomial

function ClassicalModularPolynomial(ell)
    parent, (X, Y) = Nemo.PolynomialRing(Nemo.ZZ, ["X", "Y"])
    ClassicalModularPolynomial(ell, X, Y)
end

function ClassicalModularPolynomial(ell, X, Y)
    _parse(joinpath("ModPolCls", "$ell.pol.gz")) do deg1, deg2, c
        d1, d2 = parse(deg1), parse(deg2)
        mon = X^d1 * Y^d2
        if d1 != d2
            mon += X^d2 * Y^d1
        end
        parse(BigInt, c) * mon
    end
end

function EtaModularPolynomial(ell)
    parent, (X, Y) = Nemo.PolynomialRing(Nemo.ZZ, ["X", "Y"])
    EtaModularPolynomial(ell, X, Y)
end

function EtaModularPolynomial(ell, X, Y)
    _parse(joinpath("ModPolEta", "$ell.pol.gz")) do deg1, deg2, c
        parse(BigInt, c) * X^parse(deg1) * X^parse(deg2)
    end
end

function AtkinModularPolynomial(ell)
    parent, (X, Y) = Nemo.PolynomialRing(Nemo.ZZ, ["X", "Y"])
    AtkinModularPolynomial(ell, X, Y)
end

function AtkinModularPolynomial(ell, X, Y)
    _parse(joinpath("ModPolAtk", "$ell.pol.gz")) do deg1, deg2, c
        parse(BigInt, c) * X^parse(deg1) * X^parse(deg2)
    end
end

function _parse(monomial, file)
    data = GZip.open(joinpath(DIR, file))
    res = 0
    for line in eachline(data)
        res += monomial(split(line)...)
    end
    close(data)
    return res
end

end # module
