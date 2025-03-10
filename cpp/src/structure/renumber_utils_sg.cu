/*
 * Copyright (c) 2021-2022, NVIDIA CORPORATION.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <structure/renumber_utils_impl.cuh>

namespace cugraph {

// SG instantiation

template void renumber_ext_vertices<int32_t, false>(raft::handle_t const& handle,
                                                    int32_t* vertices,
                                                    size_t num_vertices,
                                                    int32_t const* renumber_map_labels,
                                                    int32_t local_int_vertex_first,
                                                    int32_t local_int_vertex_last,
                                                    bool do_expensive_check);

template void renumber_ext_vertices<int64_t, false>(raft::handle_t const& handle,
                                                    int64_t* vertices,
                                                    size_t num_vertices,
                                                    int64_t const* renumber_map_labels,
                                                    int64_t local_int_vertex_first,
                                                    int64_t local_int_vertex_last,
                                                    bool do_expensive_check);

template void renumber_local_ext_vertices<int32_t, false>(raft::handle_t const& handle,
                                                          int32_t* vertices,
                                                          size_t num_vertices,
                                                          int32_t const* renumber_map_labels,
                                                          int32_t local_int_vertex_first,
                                                          int32_t local_int_vertex_last,
                                                          bool do_expensive_check);

template void renumber_local_ext_vertices<int64_t, false>(raft::handle_t const& handle,
                                                          int64_t* vertices,
                                                          size_t num_vertices,
                                                          int64_t const* renumber_map_labels,
                                                          int64_t local_int_vertex_first,
                                                          int64_t local_int_vertex_last,
                                                          bool do_expensive_check);

template void unrenumber_local_int_vertices<int32_t>(raft::handle_t const& handle,
                                                     int32_t* vertices,
                                                     size_t num_vertices,
                                                     int32_t const* renumber_map_labels,
                                                     int32_t local_int_vertex_first,
                                                     int32_t local_int_vertex_last,
                                                     bool do_expensive_check);

template void unrenumber_local_int_vertices<int64_t>(raft::handle_t const& handle,
                                                     int64_t* vertices,
                                                     size_t num_vertices,
                                                     int64_t const* renumber_map_labels,
                                                     int64_t local_int_vertex_first,
                                                     int64_t local_int_vertex_last,
                                                     bool do_expensive_check);

template void unrenumber_int_vertices<int32_t, false>(
  raft::handle_t const& handle,
  int32_t* vertices,
  size_t num_vertices,
  int32_t const* renumber_map_labels,
  std::vector<int32_t> const& vertex_partition_lasts,
  bool do_expensive_check);

template void unrenumber_int_vertices<int64_t, false>(
  raft::handle_t const& handle,
  int64_t* vertices,
  size_t num_vertices,
  int64_t const* renumber_map_labels,
  std::vector<int64_t> const& vertex_partition_lasts,
  bool do_expensive_check);

template void unrenumber_local_int_edges<int32_t, false, false>(
  raft::handle_t const& handle,
  int32_t* edgelist_rows /* [INOUT] */,
  int32_t* edgelist_cols /* [INOUT] */,
  size_t num_edgelist_edges,
  int32_t const* renumber_map_labels,
  int32_t num_vertices,
  bool do_expensive_check);

template void unrenumber_local_int_edges<int32_t, true, false>(raft::handle_t const& handle,
                                                               int32_t* edgelist_rows /* [INOUT] */,
                                                               int32_t* edgelist_cols /* [INOUT] */,
                                                               size_t num_edgelist_edges,
                                                               int32_t const* renumber_map_labels,
                                                               int32_t num_vertices,
                                                               bool do_expensive_check);

template void unrenumber_local_int_edges<int64_t, false, false>(
  raft::handle_t const& handle,
  int64_t* edgelist_rows /* [INOUT] */,
  int64_t* edgelist_cols /* [INOUT] */,
  size_t num_edgelist_edges,
  int64_t const* renumber_map_labels,
  int64_t num_vertices,
  bool do_expensive_check);

template void unrenumber_local_int_edges<int64_t, true, false>(raft::handle_t const& handle,
                                                               int64_t* edgelist_rows /* [INOUT] */,
                                                               int64_t* edgelist_cols /* [INOUT] */,
                                                               size_t num_edgelist_edges,
                                                               int64_t const* renumber_map_labels,
                                                               int64_t num_vertices,
                                                               bool do_expensive_check);

}  // namespace cugraph
