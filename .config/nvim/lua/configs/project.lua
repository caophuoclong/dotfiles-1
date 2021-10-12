local ok, project = pcall(require, "project_nvim")

if ok then
    project.setup {}
end
