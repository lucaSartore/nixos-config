# flake containing the necessary software to develop c++
{ config, pkgs, lib, inputs, ... }:

{

  environment.systemPackages = with pkgs; [
    # builder
    cmake

    # debugger
    # llvm.lldb
    # gdb

    # fix headers not found
    clang-tools

    # LSP and compiler
    llvmPackages.libstdcxxClang
    llvmPackages.libcxxClang

    # other tools
    llvmPackages.libllvm

    # stdlib for cpp
    llvmPackages.libcxx

  ];

}
