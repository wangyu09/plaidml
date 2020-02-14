{
name: "loc_prog"
pass: {
    [type.vertex.ai/vertexai.tile.codegen.proto.LocateMemoryPass] {
    reqs: ["program"]
    loc: { devs: [{name: "DRAM"}] }
    }
}
}
