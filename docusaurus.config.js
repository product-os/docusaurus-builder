// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: process.env.PROJECT_NAME,
  tagline: process.env.TAGLINE,
  url: process.env.URL,
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
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
        title: process.env.PROJECT_NAME,
        hideOnScroll: true,
        logo: {
          alt: process.env.PROJECT_NAME + "logo",
          src: 'img/logo.png',
        },
        items: [
          // right
          {
            href: '/changelog',
            label: 'Change Log',
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
                href: '$REPO_URL',
              },
              {
                label: 'Raise an issue',
                href: '$REPO_URL/issues/new',
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
