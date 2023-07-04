using Comonicon

# in a script or module

"""
sum two numbers.

# Args

- `x`: first number
- `y`: second number

# Options

- `-p, --precision=<type>`: precision of the calculation.

# Flags

- `-f, --fastmath`: enable fastmath.

"""
@cast function sum(x, y; precision::String="float32", fastmath::Bool=false)
    # implementation
    println("sum of $x and $y")
end

"product two numbers"
@cast function prod(x, y)
    return
end

@main
