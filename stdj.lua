function create_author(name, email, affiliations, corresponding_author)
    return {
        name=name,
        email=email,
        affiliations=affiliations,
        corresponding_author=corresponding_author
    }
end

function index_affiliations(authors)
    local affiliations = {}
    
    local affiliation_set = {}

    local affiliation_order = 1
    local affiliation_order_lookup = {}
    
    local author_affiliation_indexes = {}

    for author_index,author in ipairs(authors) do
        author_affiliation_indexes[author_index] = {}
        for _,affiliation in ipairs(author.affiliations) do
            if affiliation_set[affiliation] == nil then
                affiliation_set[affiliation] = true
                table.insert(affiliations, affiliation)
                affiliation_order_lookup[affiliation] = affiliation_order
                affiliation_order = affiliation_order + 1
            end
            table.insert(author_affiliation_indexes[author_index], affiliation_order_lookup[affiliation])
        end
    end

    return {
        affiliations=affiliations,
        affiliation_order_lookup = affiliation_order_lookup,
        author_affiliation_indexes=author_affiliation_indexes
    }
end

function get_authors(authors, author_affiliation_indexes)
    local author_labels = {}
    for author_index,author in ipairs(authors) do
        local supper_script = "" .. table.concat(author_affiliation_indexes[author_index], ", ");
        if author.corresponding_author then
            supper_script = supper_script .. ", *"
        end
        local author_label = string.format("%s\\textsuperscript{%s}", author.name, supper_script)
        table.insert(author_labels, author_label)
    end

    return table.concat(author_labels, ", ")
end

function get_affiliations(affiliations)
    local affiliation_strings = {}
    for index,affiliation in ipairs(affiliations) do
        table.insert(affiliation_strings, string.format("\\textsuperscript{%s}", index) .. affiliation)
    end
    return table.concat(affiliation_strings, "\\\\")
end

function generate_correspondences(authors, internal_space_size)
    if internal_space_size == nil or internal_space_size == "" then
        internal_space_size = "0.25cm"
    end

    local correspondences = {}
    for _,author in ipairs(authors) do
        if author.corresponding_author then
            local affiliation_string = table.concat(author.affiliations, string.format("\\par{}\\vspace{%s}", internal_space_size))
            local correspondence = string.format("\\textbf{%s}, %s\\par{}\\vspace{%s} Email: %s", author.name, affiliation_string, internal_space_size, author.email)
            table.insert(correspondences, correspondence)
        end
    end
    return correspondences;
end

function get_correspondences(authors, correspondence_label, space_size, internal_space_size)
    if correspondence_label == nil or correspondence_label == "" then
        correspondence_label = "Correspondence"
    end

    if space_size == nil or space_size == "" then
        space_size = "0.5cm"
    end

    local correspondences = generate_correspondences(authors, internal_space_size)
    local correspondence_strings = {}
    for _,correspondence in ipairs(correspondences) do
        local correspondences_string = string.format(
                "\\begin{SideSection}{%s}{%s}\\end{SideSection}",
                    correspondence_label, correspondence)
        table.insert(correspondence_strings, correspondences_string)
    end

    return table.concat(correspondence_strings, string.format("\\par{}\\vspace{%s}", space_size))
end
