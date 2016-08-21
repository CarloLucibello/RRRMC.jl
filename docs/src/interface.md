# [Graphs interface](@id interface)

```@meta
CurrentModule = RRRMC
```

This page contains all the functions which are needed when implementing a [graph type](@ref graphtype).
See the [built-in graphs](@ref builtin) for concrete examples (in particular, the RRG and EA family of
graphs have the most complete implementations). See also the documentation for the [`Config`](@ref) type.

## Functions used by all graph types

```@docs
energy
```

```@docs
delta_energy
```

```@docs
update_cache!
```

```@docs
getN
```

## Functions used by `DiscrGraph` models

```@docs
neighbors
```

```@docs
allΔE
```

## Functions used by `DoubleGraph` models

```@docs
discr_graph
```

```@docs
delta_energy_residual
```

```@docs
update_cache_residual!
```

## Functions specific to quantum models

```@docs
Qenergy
```

```@docs
transverse_mag
```
