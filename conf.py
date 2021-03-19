# -- Project information -----------------------------------------------------

project = 'Project Name'
copyright = '2021, Author'
author = 'Author'
version = ''
release = '1.0.0'

# -- General configuration ---------------------------------------------------
extensions = [
]
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
language = None
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
pygments_style = None

# -- Options for HTML output -------------------------------------------------

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
htmlhelp_basename = 'Documentation'


# -- Options for LaTeX output ------------------------------------------------

latex_elements = {
}
latex_documents = [
    (master_doc, 'Eagletrtubxparsermaster.tex', 'Eagletrt ubx parser master Documentation',
     'Harrison Prest', 'manual'),
]

# -- Options for manual page output ------------------------------------------

man_pages = [
    (master_doc, 'eagletrtubxparsermaster', 'Eagletrt ubx parser master Documentation',
     [author], 1)
]

# -- Options for Texinfo output ----------------------------------------------

texinfo_documents = [
    (master_doc, 'Eagletrtubxparsermaster', 'Eagletrt ubx parser master Documentation',
     author, 'Eagletrtubxparsermaster', 'One line description of project.',
     'Miscellaneous'),
]


# -- Options for Epub output -------------------------------------------------

epub_title = project
epub_exclude_files = ['search.html']
extensions = [
    'breathe',
    'exhale'
]
breathe_projects = {
    "My Project": "./doxyoutput/xml"
}
breathe_default_project = "My Project"

exhale_args = {
    "containmentFolder":     "./api",
    "rootFileName":          "library_root.rst",
    "rootFileTitle":         "Parser Master Documentation",
    "doxygenStripFromPath":  "..",
    "createTreeView":        True,
    "exhaleExecutesDoxygen": True,
    "exhaleDoxygenStdin":    "INPUT = ../utils"
}

# Tell sphinx what the primary language being documented is.
primary_domain = 'c'

# Tell sphinx what the pygments highlight language should be.
highlight_language = 'c'
