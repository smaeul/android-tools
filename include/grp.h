/*
 * Copyright (C) 2017 by Samuel Holland <samuel@sholland.org>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
 * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

#include_next <grp.h>

#if !defined(__GLIBC__)

#include <limits.h>

static int group_member(gid_t gid)
{
	gid_t groups[NGROUPS_MAX] = { 0 };
	int num;

	if ((num = getgroups(NGROUPS_MAX, groups)) == -1)
		return 0;
	for (int i = 0; i < num; i += 1)
		if (groups[i] == gid)
			return 1;
	return 0;
}

#endif
