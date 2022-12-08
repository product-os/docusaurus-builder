// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const { read } = require('gray-matter')

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

function getFrontmatter(field) {
  try {
    const readme = read('./README.md', { excerpt: true });
    if (typeof readme.data[field] !== 'undefined') {
      console.log(`Using ${readme.data[field]} as website ${field}`)
      return readme.data[field]
    }
    console.log(`Cannot find ${field} in README.md, using default value`)
  } catch (error) {
    throw error
  }
}

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: getFrontmatter('project_name') || process.env.PROJECT_NAME || "",
  url: process.env.URL || "",
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'throw',
  favicon: 'img/favicon.ico', // use default, but overide if available

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  plugins: [
    [
      require.resolve("@cmfcmf/docusaurus-search-local"),
      {
        indexPages: false
      },
    ],
  ],

  presets: [
    [
      '@docusaurus/preset-classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      {
        sitemap: {
          changefreq: 'weekly',
          priority: 0.5,
          ignorePatterns: ['/tags/**'],
          filename: 'sitemap.xml',
        },
        docs: {
          sidebarPath: './sidebars.js',
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            process.env.REPO_URL + '/edit/' + process.env.DEFAULT_BRANCH + '/',
          routeBasePath: '/'
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            process.env.REPO_URL + '/edit/' + process.env.DEFAULT_BRANCH + '/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      docs: {
        sidebar: {
          hideable: true,
          autoCollapseCategories: true,
        }
      },
      navbar: {
        title: getFrontmatter('project_name') || process.env.PROJECT_NAME || "",
        hideOnScroll: true,
        logo: {
          alt: (getFrontmatter('project_name') || process.env.PROJECT_NAME || "") + "logo",
          src: 'img/logo.png',
        },
        items: [
          // right
          {
            href: `${process.env.REPO_URL}/blob/${process.env.DEFAULT_BRANCH}/CHANGELOG.md`,
            label: 'Changelog',
            position: 'right',
          },
          {
            href: process.env.REPO_URL,
            label: 'Edit on GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'More Resoruces',
            items: [
              {
                label: 'balenaCloud docs',
                href: 'https://balena.io/docs',
              },
              {
                label: 'Blog',
                href: 'https://balena.io/blog',
              },
              {
                label: 'Website',
                href: 'https://balena.io',
              },
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: 'Twitter',
                href: 'https://twitter.com/balena_io',
              },
              {
                label: 'Forums',
                href: 'https://forums.balena.io/',
              },

            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'GitHub',
                href: process.env.REPO_URL,
              },
              {
                label: 'Raise an issue',
                href: process.env.REPO_URL + '/issues/new',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Imagined by balena. Built with Docusaurus.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
