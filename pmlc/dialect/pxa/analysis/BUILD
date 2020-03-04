# Copyright 2020 Intel Corporation

package(default_visibility = ["//visibility:public"])

load("//bzl:plaidml.bzl", "plaidml_cc_library", "plaidml_cc_test")

plaidml_cc_library(
    name = "analysis",
    srcs = [
        "read_write.cc",
        "strides.cc",
    ],
    hdrs = [
        "read_write.h",
        "strides.h",
    ],
    deps = [
        "//pmlc/dialect/pxa/ir",
    ],
)
