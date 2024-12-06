SELECT marta_routes.route_short_name, marta_routes.route_long_name, marta_stops.stop_name, 
    marta_stops.stop_lat, marta_stops.stop_lon, marta_stop_times.arrival_time, marta_stop_times.departure_time, 
    CASE 
        WHEN marta_stops.wheelchair_boarding = 1 THEN 'Accessible'
        ELSE 'Not Accessible'
    END AS accessibility_status
FROM marta_routes
JOIN marta_trips ON marta_routes.route_id = marta_trips.route_id
JOIN marta_stop_times ON marta_trips.trip_id = marta_stop_times.trip_id
JOIN marta_stops ON marta_stop_times.stop_id = marta_stops.stop_id
JOIN marta_calendar_dates ON marta_trips.service_id = marta_calendar_dates.service_id
WHERE marta_calendar_dates.date = '2024-01-01' AND marta_trips.wheelchair_accessible = 1 AND (marta_routes.route_short_name !~ '^\d+$' OR marta_routes.route_short_name ~ '^\d+$') 
ORDER BY marta_routes.route_short_name, marta_stop_times.stop_sequence;