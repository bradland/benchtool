# This file loads extensions to Core and Stdlib classes and modules

# Mix-in to provide deep_symbolize method to Hash
class Hash; include DeepSymbolizable; end
