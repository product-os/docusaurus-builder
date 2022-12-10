# Balena Docusaurus Theme

> Generate clear docs websites for your projects with zero configuration

This is the official theme for balena docs. Websites is built using [Docusaurus 2](https://docusaurus.io/), a modern static website generator. The repository is host to a customized docusarus theme and it's GitHub action. The GitHub action parses, prepares and generates documentation when running on a GitHub repository.

![](https://user-images.githubusercontent.com/22801822/206838272-e3a2990b-4855-4e71-b9da-7270357c2028.png)

## Getting Started 

### I have docs, I need a website

Let jump straight into building your first website. 

1. Create a new Cloudflare Pages project by using the `direct upload` option or ask ops/admins to do it for you.
2. Decide a project name. If available on Cloudflare, then this will be your URL: `project-name.pages.dev`
3. Once that is complete, make this API call to change the project's default branch to master or main or whatever your GitHub project uses.

```bash
curl -X PATCH "https://api.cloudflare.com/client/v4/accounts/$CF_ACCOUNT_ID/pages/projects/project-name"   -H "Authorization: Bearer $CF_API_KEY"      -H "Content-Type: application/json"      --data ' {"production_branch": "$GITHUB_BRANCH","production_deployments_enabled": true}' -v
```

4. In your exisitng `flowzone.yml` file, add a `cloudflare_website` variable in the `with:` section with the value of the variable being the Cloudflare project name you decided. 

```yml
name: Flowzone

on:
  pull_request:
    types: [opened, synchronize, closed]
    branches:
      - "main"
      - "master"

jobs:
  flowzone:
    name: Flowzone
    uses: product-os/flowzone/.github/workflows/flowzone.yml@master
    secrets: inherit
    with:
       cloudflare_website: "CLOUDFLARE_PROJECT_NAME"
```

And, you are done! Make a pull request and you should see the docusaurus action running as part of your Flowzone steps. 

![](https://user-images.githubusercontent.com/22801822/206837518-3f484261-c423-4ea9-a6fb-0a95b4a77a57.png)

### What did I just do? 

1. You created a new project on Cloudflare Pages to deploy your docs website on. It's exactly like GitHub pages but better. 
2. You then did a bit of configuration to get Cloudflare Pages automated correctly. Or atleast someone did it for you. 
3. You configured the docusaurus builder with the required inputs to start building on your repository.
4. If everything went well, then a preview URL will appear in the Flowzone run summary which you can use to view your docs website.

This is no magic, only hard automation. You just deployed a docusaurus website on Cloudflare Pages. To learn more about docusaurus, go through their [docs](https://docusaurus.io/docs/category/guides) and make use of [powerful features](https://docusaurus.io/docs/markdown-features) available to document better. 

### I got a website, how do I make it better?

We believe in maximum input that can be infered directly from source. Hence to enable you in building docs, we need no configuration. The docusaurus theme GitHub action infers information from your repository with sensible defaults. Here's some of the things the builder looks out for: 

**Pre-requistes for running the GitHub action on Flowzone**

1. A README file in the root of the repository
2. An input named as `cloudflare_website` in the flowzone.yml file. 

**Good to have**

1. Markdown docs present in either a docs directory called `docs` or `balena-docs`
2. [Assets/images/files](https://docusaurus.io/docs/markdown-features/assets) being used in the docs being present inside the docs directory as mentioned in point 1 referenced using [markdown links](https://docusaurus.io/docs/markdown-features/links). 
3. A favicon file present in the root named as `favicon.ico`
4. A logo file present in the root named as `logo.png`

This list is exhaustive. Will contine to add to it. Docs are constantly evolving, but always degrading. A little attention to detail will be neeed. 

## Testing sites locally 

Atm, we don't support local builds.
To test your content on docusarus conventions, checkout https://docusaurus.io/docs/playground
To preview how your website will end up looking, make your PR on a docusaurus-enabled repository and the preview URL will be generated. 
To add new features to the theme, you can start contributing here!

