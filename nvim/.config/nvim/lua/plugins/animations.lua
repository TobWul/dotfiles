return {
	"sphamba/smear-cursor.nvim",
	event = "VeryLazy",
	opts = {
		stiffness = 0.9,
		trailing_stiffness = 0.85,
		damping = 0.8,
		matrix_pixel_threshold = 0.5,
		smear_between_buffers = false,
		never_draw_over_target = false,
	},
}
