
//Implement Brown Transformation


// Check if Stars > 4

//Repeat over every combination of three stars from the sensed stars
	// If too many iterations return Error

	// Find catalog stars
	
	// Get possible candiate pairs {0/1: find_pair(0,1), 0/2: find_pair(0,2), 1/2: find_pair(1,2)}

	    // Otherwise, there exists |big_i| choose 3 possibilities. Looping specified in paper.



//Two Databases
//One for the angle between two stars sorted by combined magnitude
// Implied(12) Angle
// Implied(13) Angle
//Second for the position of the stars sorted by magnitude
//1 Declination Right_Ascension

// Convert to GrayScale
// Blur Image iwht normalized Box Filter
// Convert to Binary Black/White Scale
// Find Contours
// Compute Moment of Contour
// Compute Center of Mass from Moment
// Translate pixels so that (0,0) is centered
// Inverse Mercator Projection with ellipsoid
// Project to Vector3D

//Identify
//Databse is organized by magnitude

//Vector of Stars that are sorted by the brightest
// let stars = vec![]

// let iteration = 0;

// // Repeat over every pair of Star(i,j)
// for i in 0..stars.len() {
// for j in (i + 1)..stars.len() {

// iteration += 1;

// // Return if too many comparisons(e.g. Lose Hope)
// if iteration > MAX_ITERATIONS {
// 	return Err("Too many iterations");
// }

// //Find Possible Pair

// // Compute theta between two stars
// let theta = compute_theta(stars[i], stars[j]);
// // If angle is too wide(> FOV) continue
// if theta > FOV {
// 	continue;
// }
// // Search Database for two stars that match angle with epsilon
// // If no pair is found continue
// let potential_pair = DATABASE::search(theta, epsilon)?;
	
// // Generate possible neably stars
// let possible_nearby_stars: Vec<Star> = DATABASE::search_nearby(stars[i], stars[j], epsilon)?;//(Could be improvd)

// // DMT(Direct Match Test) List of possible candiate stars along with the possible pair
// 	// Repeat by flipping which star is at what position(e.g. STAR A == position 1 || STAR B == position 2)

// 	let quarternion = Quaternion::from_two_vectors(stars[i], stars[j]);
// 	// Compute Quaternion between A/B


// 	// For every possible nearby stars
// 		// Rotate star by quarternion
		
// 		// Repeat for every star in the image
// 			// If Star is with epsilon angle of possible nearby stars

// }
// }