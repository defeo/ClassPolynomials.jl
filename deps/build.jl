MIRROR = "https://zenodo.org/record/3633228/files/"
TARFILES = ["ModPolCls.tar", "ModPolEta.tar", "ModPolAtk.tar", "ModPolWeb.tar"]

cd(Pkg.dir("ClassPolynomials", "deps"))

for f in TARFILES
    download("$MIRROR/$f", f)
    run(`tar xf $f`)
    rm(f)
end
