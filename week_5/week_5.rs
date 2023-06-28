fn findit(s: i32, items: Vec<i32>) -> i32 {
    let limit = (items.len() + 1) as i32;
    let mut shortest = limit;
    for i in 0..limit {
        for k in 0..limit {
            if i > k {
                continue;
            }
            if items[(i as usize)..(k as usize)].iter().sum::<i32>() >= s {
                if (i - k).abs() < shortest {
                    shortest = (i - k).abs();
                }
            }
        }
    }
    if shortest == limit {
        0
    } else {
        shortest
    }
}

fn main() {
    let tests = vec![
        // (name, s, answer, data),
        ("1", 7, 2, vec![2, 1, 5, 2, 3, 2]),
        ("2", 7, 1, vec![2, 1, 5, 2, 8]),
        ("3", 8, 3, vec![3, 4, 1, 1, 6]),
        (
            "Return 0 if no such subarray exists",
            9,
            0,
            vec![4, 1, 1, 1],
        ),
    ];

    tests.into_iter().for_each(|(name, s, answer, data)| {
        if findit(s, data) != answer {
            panic!("{}", name)
        }
    });
}
