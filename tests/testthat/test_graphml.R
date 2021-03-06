# Copyright 2018 IBM Corp.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

context("graphml")

test_that("round trip graph with no attributes through GraphML", {
  g = multigraph()
  add_nodes(g, c("u","v","w"))
  add_edge(g, "u", "v")
  add_edge(g, "u", "w")
  add_edge(g, "v", "w")
  xml = write_graphml(g)
  h = read_graphml(xml)
  expect_equal(h, g)
})

test_that("round trip attributed graph through GraphML", {
  g = multigraph(list(name="g"))
  add_node(g, "u", list(bar=TRUE, baz=FALSE))
  add_nodes(g, c("v","w"))
  add_edge(g, "u", "v", list(foo=1L))
  add_edge(g, "u", "w", list(foo=2L))
  add_edge(g, "v", "w", list(foo=3L))
  xml = write_graphml(g)
  h = read_graphml(xml)
  expect_equal(h, g)
})

test_that("round trip wiring diagram with no attributes through GraphML", {
  g = wiring_diagram("x", "z")
  add_node(g, "f", "x", "y")
  add_node(g, "g", "y", "z")
  add_edge(g, input_node(g), "f", "x", "x")
  add_edge(g, "f", "g", "y", "y")
  add_edge(g, "g", output_node(g), "z", "z")
  xml = write_graphml(g)
  h = read_graphml(xml, wiring_diagram())
  expect_equal(h, g)
})