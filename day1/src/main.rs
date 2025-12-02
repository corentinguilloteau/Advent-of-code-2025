#[derive(PartialEq)]
pub enum Direction {
    Left,
    Right,
}

impl Direction {
    pub fn from_str(s: &str) -> Self {
        match s {
            "L" => Direction::Left,
            "R" => Direction::Right,
            _ => panic!("Unknown direction"),
        }
    }
}

pub struct Dial {
    count: i32,
}

impl Dial {
    pub fn new(inital_count: i32) -> Self {
        Dial {
            count: inital_count,
        }
    }

    pub fn command(&mut self, direction: Direction, steps: u32) -> u32 {
        let mut at_0_count = u32::div_euclid(steps, 100);
        let remaining_steps = steps % 100;
        let previous_count = self.count;

        match direction {
            Direction::Left => self.count -= remaining_steps as i32,
            Direction::Right => self.count += remaining_steps as i32,
        };

        at_0_count += if previous_count > 0 && self.count <= 0 || self.count >= 100 {
            1
        } else {
            0
        };
        self.count = i32::rem_euclid(self.count, 100);

        return at_0_count;
    }
}

fn main() {
    let mut counter = Dial::new(50);
    let mut at_0_step1 = 0;
    let mut at_0_step2 = 0;

    for line in std::fs::read_to_string("input").unwrap().lines() {
        let direction = Direction::from_str(&line[0..1]);
        let steps: u32 = line[1..].parse().unwrap();

        at_0_step2 += counter.command(direction, steps);
        if counter.count == 0 {
            at_0_step1 += 1;
        }
    }

    println!("Final count step 1: {}", at_0_step1);
    println!("Final count step 2: {}", at_0_step2);
}
