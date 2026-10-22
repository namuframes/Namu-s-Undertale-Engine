if (surface_exists(surf)) {surface_free(surf)};
if (surface_exists(surf_buff)) {surface_free(surf_buff)};
if (buffer_exists(surf_buff)) {buffer_delete(surf_buff)};
if (vb != -1) {vertex_delete_buffer(vb)};
if (vf != -1) {vertex_format_delete(vf)};