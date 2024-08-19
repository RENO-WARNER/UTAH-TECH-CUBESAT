use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use std::str::FromStr;

#[derive(Debug)]
struct Star {
    ra: f32,
    dec: f32,
    vmag: f32,
}



impl Star {
	fn angle(a: &Star, b: &Star) -> f32 {
		return (a.dec.sin() * b.dec.sin() + a.dec.cos() * b.dec.cos() * (a.ra - b.ra).cos()).acos();
	}
}

fn parse_star_line(line: &str) -> Option<Star> {
    let id = u16::from_str(&line[0..4].trim()).ok()?;

	//Right Ascension
    let ra_h = u8::from_str(&line[76..78].trim()).ok()? as f32;
    let ra_m = u8::from_str(&line[78..80].trim()).ok()? as f32;
    let ra_s = f32::from_str(&line[80..84].trim()).ok()?;
    let ra = ra_h * 15.0 + ra_m / 4.0 + ra_s / 240.0;

	//Deciation
    let dec_sign = if &line[84..85] == "+" { 1.0 } else { -1.0 };
    let dec_d = u8::from_str(&line[85..87].trim()).ok()? as f32;
    let dec_m = u8::from_str(&line[87..89].trim()).ok()? as f32;
    let dec_s = u8::from_str(&line[89..91].trim()).ok()? as f32;
    let dec = dec_sign * (dec_d + dec_m / 60.0 + dec_s / 3600.0);

    let vmag = f32::from_str(&line[103..108].trim()).ok()?;

    Some(Star { id, ra, dec, vmag })
}

fn read_stars_from_file(filename: &str) -> io::Result<Vec<Star>> {
    let mut stars = Vec::new();

    let file = File::open(filename)?;
    for line in io::BufReader::new(file).lines() {
        if let Ok(line) = line {
            if let Some(star) = parse_star_line(&line) {
                stars.push(star);
            }
        }
    }

    stars.sort_by(|a, b| a.vmag.partial_cmp(&b.vmag).unwrap());
    Ok(stars)
}

fn main() -> io::Result<()> {
    let filename = "./catalog/bsc5.dat";

    let stars = read_stars_from_file(filename)?;

    let star_tuples: Vec<(u16, f32, f32)> = stars
        .iter()
        .map(|star| (star.id, star.ra, star.dec))
        .collect();

	let angles = stars.iter().tuple_combinations(2).map(|(a,b)| {
		return Star::angle(a,b);
	}).collect();

    for star in &star_tuples {
        println!("{:?}", star);
    }

    Ok(())
}


// Database 1
// 
//