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

pub struct Counter {
    count: i32,
}

impl Counter {
    pub fn new(inital_count: i32) -> Self {
        Counter {
            count: inital_count,
        }
    }

    pub fn command(&mut self, direction: Direction, steps: i32) {
        match direction {
            Direction::Left => self.count = i32::wrapping_sub(self.count, steps),
            Direction::Right => self.count = i32::wrapping_add(self.count, steps),
        };

        self.count %= 100;
    }
}

fn main() {
    let mut counter = Counter::new(50);
    let mut at_0 = 0;

    for line in std::fs::read_to_string("input").unwrap().lines() {
        let dir = &line[0..1];
        let steps = &line[1..];
        let steps: i32 = steps.parse().unwrap();

        counter.command(Direction::from_str(dir), steps);

        if counter.count == 0 {
            at_0 += 1;
        }
    }

    println!("Final count: {}", at_0);
}
