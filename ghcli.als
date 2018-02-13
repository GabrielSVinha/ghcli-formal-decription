module ufcg/softwareengineering/Ghcli

sig GithubUser{
  followers: set GithubUser,
  repos: set Repository,
  comments: set Comment,
  prs: set PullRequest
}

sig Repository{
  issues: set Issue,
  pullRequests: set PullRequest
}

sig PullRequest{
  prComments: some Comment
}

sig Issue{
  issueComments: some Comment
}

// TO-DO: one comment cannot belong to issue and pull request

pred follow[from, from': GithubUser, to: GithubUser]{
  from' = from
  to not in from.followers
  from'.followers = from.followers + to
}

// TO-DO: add pred to follow/unfollow, comment

sig Comment{}

fact issuesMustBelongToArepository{
  all i: Issue | #i.~issues = 1
}

fact prsMustBelongToRepo{
  all p: PullRequest | #p.~pullRequests = 1
}

fact commentsBelongToOneIssueAndUser{
  all c: Comment | #c.~issueComments = 1 and #c.~comments = 1
}

fact commentsBelongToOnePRAndUser{
  all c: Comment | #c.~prComments = 1 and #c.~comments = 1
}

fact allReposBelongToAnUser{
  all r: Repository | r in GithubUser.*repos
}

fact reposHaveOneOwner{
  all r: Repository | #r.~repos = 1
}

fact doesntFollowYourself{
  no u: GithubUser, f: u.followers | f = u
}

pred show(){}
run follow for 4 GithubUser, 3 Repository, 3 Issue, 4 Comment, 3 PullRequest
