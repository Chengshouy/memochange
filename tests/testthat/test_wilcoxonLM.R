context("wilcoxonLM")
set.seed(410)
T     <- 100
d     <- 0
x     <- fracdiff::fracdiff.sim(n=T, d=d)$series

expect_error(wilcoxonLM(c(x,NA), d=d))
expect_error(wilcoxonLM(x, d=d,tau=2))
expect_warning(wilcoxonLM(x, d=d, tau=0.1))
x=stats::ts(x)
expect_error(wilcoxonLM(x, d=d))


# size
T         = 100
d_grid    = c(0.1,0.2)
  for(b in 1:length(d_grid))
  {
    d     = d_grid[b]
    q     = 0
      for(i in 1:15)
      {
        x     = fracdiff::fracdiff.sim(n=T, d=d)$series
        mod   = wilcoxonLM(x, d=d)
        q     = q+sum(mod[4]>mod[3])
      }
      expect_lt(q,11)  #test should not reject H0 (which is true) in more than 10 of 15 cases at the 99 percent level
  }

# power
T         = 100
d_grid    = c(0.1,0.2)
for(b in 1:length(d_grid))
{
  d     = d_grid[b]
  q     = 0
  for(i in 1:15)
  {
    x       = fracdiff::fracdiff.sim(n=T, d=d)$series
    changep = c(rep(0,T/2), rep(1,T/2))
    x       = x+changep
    mod     = wilcoxonLM(x, d=d)
    q       = q+sum(mod[4]>mod[1])
  }
      expect_gt(q,2) #test should reject H0 at least in three of 15 cases at the 90 percent level
}