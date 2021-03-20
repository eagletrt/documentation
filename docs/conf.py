# -- Project information -----------------------------------------------------

project = '{{PROJECT}}'
copyright = '2021, {{AUTHOR}}'
author = '{{AUTHOR}}'
version = '{{VERSION}}'
release = '{{RELEASE}}'

exhale_args = {
    "containmentFolder":     "./api",
    "rootFileName":          "library_root.rst",
    "rootFileTitle":         "{{ROOTFILETITLE}}",
    "doxygenStripFromPath":  "..",
    "createTreeView":        True,
    "exhaleExecutesDoxygen": True,
    "exhaleDoxygenStdin":    "INPUT = {{FOLDERS}}"
}
# Tell sphinx what the primary language being documented is.
primary_domain = '{{LANGUAGE}}'
highlight_language = '{{LANGUAGE}}'




html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']




# -- General configuration ---------------------------------------------------
extensions = [
]
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
language = None
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
pygments_style = None
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
