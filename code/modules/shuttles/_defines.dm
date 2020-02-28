// Shuttle flags
#define SHUTTLE_FLAGS_NONE    0
#define SHUTTLE_FLAGS_PROCESS 1		// Should be processed by shuttle subsystem
#define SHUTTLE_FLAGS_SUPPLY  2		// This is the supply shuttle.  Why is this a tag?
#define SHUTTLE_FLAGS_ZERO_G  4		// Shuttle has no internal gravity generation
#define SHUTTLE_FLAGS_ALL (~SHUTTLE_FLAGS_NONE)

// shuttle_landmark flags
#define SLANDMARK_FLAG_AUTOSET 1    // If set, will set base area and turf type to same as where it was spawned at
#define SLANDMARK_FLAG_ZERO_G  2    // Zero-G shuttles moved here will lose gravity unless the area has ambient gravity.


#define FERRY_LOCATION_STATION	0
#define FERRY_LOCATION_OFFSITE	1
#define FERRY_GOING_TO_STATION	0
#define FERRY_GOING_TO_OFFSITE	1

// Uncomment this to turn on verbose shuttle code debugging
#define DEBUG_SHUTTLES

#ifndef DEBUG_SHUTTLES
	#define log_shuttle(M)
	#define shuttle_entered(PROCNAME)
	#define shuttle_exit(PROCNAME)
#else
	#define log_shuttle(M) log_debug("[M]")
	#define shuttle_entered(PROCNAME) log_debug("[PROCNAME] [__FILE__] - [__LINE__] Entering:"); for(var/arg in args) { log_debug("\t[log_info_line(arg)]") }
	#define shuttle_exit(PROCNAME) log_debug("[PROCNAME] [__FILE__] - [__LINE__] Exiting = [log_info_line(.)]")
#endif
