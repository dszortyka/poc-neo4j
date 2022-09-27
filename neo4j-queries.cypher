
""" queries to delete a Node Label """
MATCH (del:USERS) DETACH DELETE del;
MATCH (del:PROJECTS) DETACH DELETE del;
MATCH (del:REPOSITORIES) DETACH DELETE del;
MATCH (del:BRANCHES) DETACH DELETE del;
MATCH (del:COMMITS) DETACH DELETE del;



""" Load data from CSV specifying names """

" PROJECTS "
LOAD CSV WITH HEADERS FROM 'file:///PROJECTS.csv' AS row
WITH row WHERE row.id IS NOT NULL
MERGE (p:PROJECTS {ProjectId: row.id, ProjectName: row.project_name});

" REPOSITORIES "
LOAD CSV WITH HEADERS FROM 'file:///REPOSITORIES.csv' AS row
WITH row WHERE row.id IS NOT NULL
MERGE (r:REPOSITORIES {RepoId: row.id, ProjectId: row.project_id, RepoName: row.repo_name});

" BRANCHES "
LOAD CSV WITH HEADERS FROM 'file:///BRANCHES.csv' AS row
WITH row WHERE row.id IS NOT NULL
MERGE (r:BRANCHES {BranchId: row.id, RepoId: row.repo_id, BranchName: row.branch_name});

" COMMITS "
LOAD CSV WITH HEADERS FROM 'file:///COMMITS.csv' AS row
WITH row WHERE row.id IS NOT NULL
MERGE (r:COMMITS {CommitId: row.id, BranchId: row.branch_id, UserId: row.user_id, CommitTimestamp: row.commit_timestamp});

" USERS "
LOAD CSV WITH HEADERS FROM 'file:///USERS.csv' AS row
WITH row WHERE row.id IS NOT NULL
MERGE (p:USERS {UserId: row.id, FirstName: row.first_name, LastName: row.last_name, Email: row.email});



" Relationship "
" This example only MERGE Projects with Repositories "
LOAD CSV WITH HEADERS FROM 'file:///REPOSITORIES.csv' AS row
WITH row WHERE row.id IS NOT NULL
MERGE (r:REPOSITORIES {RepoId: row.id, ProjectId: row.project_id, RepoName: row.repo_name})
WITH r, row
MATCH (p:PROJECTS {ProjectId: row.id})
MERGE (p)-[c:CONTAINS]->(r)


" Just return the data, it won't create any relationship "
MATCH(c:COMMITS)
WITH c
MATCH(u:USERS {UserId: c.UserId})
MATCH(b:BRANCHES {BranchId: c.BranchId})
MATCH(r:REPOSITORIES {RepoId: b.RepoId})
MATCh(p:PROJECTS {ProjectId: r.RepoId})
RETURN p.ProjectName, r.RepoName, b.BranchName, u.Email, c.CommitId, c.CommitTimestamp;


" This will Merge the relationship between nodes based on attributes "
" The final result can be visualized via http://127.0.0.1:7474 "
MATCH(c:COMMITS)
WITH c
MATCH(u:USERS {UserId: c.UserId})
MATCH(b:BRANCHES {BranchId: c.BranchId})
MATCH(r:REPOSITORIES {RepoId: b.RepoId})
MATCh(p:PROJECTS {ProjectId: r.RepoId})
MERGE (p)-[contains_proj:PROJ_CONTAINS_REPO]->(r)
MERGE (r)-[contains_repo:REPO_CONTAINS_BRANCH]->(b)
MERGE (b)-[contains_branch:BRANCH_CONTAINS_COMMITS]->(c)
MERGE (c)-[commited_by:COMMITED_BY]->(u);







