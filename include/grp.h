#include <limits.h>

#include_next <grp.h>

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
