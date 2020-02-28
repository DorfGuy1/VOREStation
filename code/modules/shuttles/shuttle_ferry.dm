#define DOCK_ATTEMPT_TIMEOUT 200	//how long in ticks we wait before assuming the docking controller is broken or blown up.

/datum/shuttle/autodock/ferry
	var/location = FERRY_LOCATION_STATION	//0 = at area_station, 1 = at area_offsite
	var/direction = FERRY_GOING_TO_STATION	//0 = going to station, 1 = going to offsite.

	var/always_process = FALSE // TODO -why should this exist?

	var/obj/effect/shuttle_landmark/waypoint_station  //This variable is type-abused initially: specify the landmark_tag, not the actual landmark.
	var/obj/effect/shuttle_landmark/waypoint_offsite  //This variable is type-abused initially: specify the landmark_tag, not the actual landmark.

	category = /datum/shuttle/autodock/ferry

/datum/shuttle/autodock/ferry/New(var/_name)
	if(waypoint_station)
		waypoint_station = SSshuttle.get_landmark(waypoint_station)
	if(waypoint_offsite)
		waypoint_offsite = SSshuttle.get_landmark(waypoint_offsite)

	..(_name, get_location_waypoint(location))

	next_location = get_location_waypoint(!location)


//Gets the shuttle landmark associated with the given location (defaults to current location)
/datum/shuttle/autodock/ferry/proc/get_location_waypoint(location_id = null)
	if (isnull(location_id))
		location_id = location

	if (location_id == FERRY_LOCATION_STATION)
		return waypoint_station
	return waypoint_offsite

/datum/shuttle/autodock/ferry/short_jump(var/destination)
	direction = !location // Heading away from where we currently are
	. = ..()

/datum/shuttle/autodock/ferry/long_jump(var/destination, var/obj/effect/shuttle_landmark/interim, var/travel_time)
	direction = !location // Heading away from where we currently are
	. = ..()

/datum/shuttle/autodock/ferry/perform_shuttle_move()
	..()
	ASSERT(current_location == next_location)
	if (next_location == waypoint_station) location = FERRY_LOCATION_STATION
	if (next_location == waypoint_offsite) location = FERRY_LOCATION_OFFSITE
	// TODO Leshana - Alternatively...
	if (current_location == waypoint_station) location = FERRY_LOCATION_STATION
	if (current_location == waypoint_offsite) location = FERRY_LOCATION_OFFSITE

// Once we have arrived where we are going, plot a course back!
/datum/shuttle/autodock/ferry/process_arrived()
	..()
	next_location = get_location_waypoint(!location)
