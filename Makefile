figure-gc-coverage.png: figure-gc-coverage.R gc.coverage.RData
	R --no-save < $<
gc.coverage.RData: gc.coverage.R
	R --no-save < $<
