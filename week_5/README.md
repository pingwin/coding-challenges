PROBLEM:

Given an array of positive integers and a number 'S,' find the length of the smallest contiguous subarray whose sum is greater than or equal to 'S'.

Return 0 if no such subarray exists.

==============================================================

func TestCase(t *testing.T) {
	tests := []struct {
		name  string
		array []int
		s     int
		want  int
	}{
		{
			name:  "1",
			array: []int{2, 1, 5, 2, 3, 2},
			s:     7,
			want:  2,
		},
		{
			name:  "2",
			array: []int{2, 1, 5, 2, 8},
			s:     7,
			want:  1,
		},
		{
			name:  "3",
			array: []int{3, 4, 1, 1, 6},
			s:     8,
			want:  3,
		},
		{
			name:  "Return 0 if no such subarray exists",
			array: []int{4, 1, 1, 1},
			s:     9,
			want:  0,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := findMinSubArray(tt.array, tt.s)
			require.Equal(t, tt.want, got)
		})
	}
}
