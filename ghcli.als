module ufcg/softwareengineering/Ghcli

sig GithubUser{
  followers: set GithubUser,
  repos: set Repositories
}

sig Repositories{}

fact allReposBelongToAnUser{
  all r: Repositories | r in GithubUser.*repos
}

fact reposHaveOneOwner{
  all r: Repositories | #r.~repos  = 1
}

fact doesntFollowYourself{
  no u: GithubUser, f: u.followers | f = u
}

pred show(){}
run show for 6
