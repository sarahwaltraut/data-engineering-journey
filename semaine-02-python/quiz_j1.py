a = [{"ville": "Lyon"}]
b = a.copy()
b[0]["ville"] = "Paris"
print(a)
# [{"ville": "Paris"}]


# ----------------------------------------------------
x = "10"
print(x * 2, int(x) * 2)
# 1010 20

# ----------------------------------------------------
valeur = ""
print(valeur is None, bool(valeur), valeur == None)
# false, false, false

# -----------------------------------------------------
def f(liste):
    liste.append(4)

nombres = [1, 2, 3]
f(nombres)
print(nombres)
# [1, 2, 3, 4]

# --------------------------------------------------
def g(n):
    n = n + 1

x = 5
g(x)
print(x)
# 6

# -------------------------------------------------
print(type(3 / 1), 0.1 + 0.2 == 0.3)
# float , boolean

# ------------------------------------------------
prix = 12.5
print(f"Total : {prix * 3:.2f} €")
# Total : 37.50 €