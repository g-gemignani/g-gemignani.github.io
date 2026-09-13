#let maroon = rgb("#822434")
#let linkblue = rgb("#000C8B")
#let RULE = 220.7pt

#set page(
  width: 595.5pt,
  height: 842.25pt,
  margin: (left: 0pt, right: 0pt, top: 30pt, bottom: 24pt),
  background: place(top + left, dx: RULE, rect(width: 1.4pt, height: 100%, fill: maroon)),
)
#set text(font: "Poppins", size: 9pt, fill: black, hyphenate: false,
  top-edge: 0.75em, bottom-edge: -0.25em)
#set par(justify: true, leading: 3pt, spacing: 7pt)
#show link: it => text(fill: linkblue, underline(it))

#let heading-l(title) = block(above: 16pt, below: 13pt)[
  #text(font: "Tenor Sans", size: 13pt, tracking: 3.2pt)[#upper(title)]
]

#let side = (body) => pad(left: 33pt, right: 16pt, body)
#let main = (body) => pad(left: 27.2pt, right: 47.5pt, body)

#let dot(filled) = box(
  baseline: 0pt,
  rect(width: 5pt, height: 5pt, fill: if filled { black } else { rgb("#c8c8c8") }),
)

#let language(name, level) = block(below: 7pt)[
  #grid(
    columns: (58pt, 1fr),
    text(size: 9pt, weight: "medium")[#name],
    box(inset: (top: 1.5pt))[#for i in range(5) [#dot(i < level)#h(4pt)]],
  )
]

#let job(title, dates, company, bullets, keywords) = block(below: 14pt, breakable: false)[
  #grid(
    columns: (212pt, 1fr),
    align: (left, right + horizon),
    par(justify: false, text(size: 12pt, weight: "medium", fill: maroon)[#title]),
    text(size: 9pt)[#dates],
  )
  #v(-4pt)
  #text(size: 9pt, weight: "semibold")[#company]
  #v(1pt)
  #bullets
  #v(1pt)
  #text(size: 9pt)[#emph[Keywords]: #keywords]
]

#let edu(degree, school, note, years) = block(below: 11pt)[
  #text(size: 12pt, weight: "medium")[#degree]
  #v(-2pt)
  #pad(left: 20pt)[
    #text(size: 9pt, weight: "semibold")[#school] \
    #text(size: 9pt)[#note, #years]
  ]
]

#let extra(title, note) = block(below: 9pt)[
  #list(text(size: 9pt, weight: "semibold")[#title])
  #v(-4pt)
  #pad(left: 21pt, text(size: 9pt)[#note])
]

#set list(
  marker: box(baseline: -1.2pt, circle(radius: 1.5pt, fill: black)),
  indent: 0pt,
  body-indent: 7.5pt,
)

// ---------------------------------------------------------------- page 1
#grid(
  columns: (RULE, 1fr),
  side[
    #align(center)[
      #box(clip: true, radius: 50%, width: 128pt, height: 128pt)[
        #image("photo.jpg", width: 128pt, height: 128pt, fit: "cover")
      ]
    ]

    #heading-l[Contact]

    #grid(
      columns: (22pt, 1fr),
      row-gutter: 11pt,
      align: (center + horizon, left + horizon),
      image("icon-phone.png", width: 10pt), text(size: 9pt)[-],
      image("icon-web.png", width: 10pt), link("https://g-gemignani.github.io")[g-gemignani.github.io],
      image("icon-mail.png", width: 11pt), text(size: 9pt)[guglielmogemignani\@gmail.com],
      image("icon-pin.png", width: 8pt), text(size: 9pt)[81369, Munich, Germany],
    )

    #heading-l[Education]

    #edu[PhD Visitor][Carnegie Mellon University][CORAL Laboratory][2014-2015]
    #edu[PhD in Robotics and Artificial Intelligence][Sapienza, University of Rome][#emph[Thesis]: Acquiring Knowledge Through Multi-Modal Human-Robot Interaction][2012-2016]
    #edu[Laurea Magistrale in Electronic Physics][Sapienza, University of Rome][#emph[Thesis]: Study of the Readout System of a Microcapillary Position Detector Filled with Scintillating Liquid][2010-2012]
    #edu[Laurea Triennale in Physics][Università degli studi di Pisa][#emph[Thesis]: Numerical Solution of the Unidimensional Schrödinger Equation][2007-2010]
  ],
  main[
    #pad(right: -22pt)[#text(size: 28pt, weight: "medium")[Guglielmo Gemignani]]
    #v(-2pt)
    #text(size: 17pt, fill: maroon)[Head of Software]

    #heading-l[Profile]

    A robotics and AI expert with 15+ years of experience and more than eight
    years leading engineering teams. Currently leads the software department of a
    startup building uncrewed aerial systems, covering drone software and Ground
    Control Stations, from architecture and autonomy to simulation, software QA, and
    compliance with aerospace standards. Holds a PhD in Robotics and Artificial
    Intelligence, with 20+ academic publications and four patents.

    #heading-l[Work Experience]

    #job[Head of Software][Jul 2026 - Present][Twentyfour Industries | Munich][
      - Lead the software department of a startup building uncrewed aerial systems.
      - Responsible for drone software and Ground Control Stations, from architecture and autonomy to simulation and software quality assurance.
      - Own compliance with aerospace standards, and hire and grow the engineering organization.
    ][UAS, Ground Control Stations, Autonomy, Simulation, SW QA, Aerospace Standards, Hiring]

    #job[Head of Robotic Integration][Mar 2022 - Jul 2026][Magazino - a Jungheinrich Company | Munich][
      - Disciplinary supervisor and technical lead for a team of 20+ developers across two companies.
      - Responsible for robot architecture design, behavior development, robot simulators, and software quality assurance.
      - Focus on developing high-level software for autonomous robots, including #link("https://www.youtube.com/watch?v=GkgxTrbMg0s")[TORU], #link("https://www.youtube.com/watch?v=LX86Kj5-U3I")[SOTO], and #link("https://www.youtube.com/watch?v=R-jDYvZLctU")[Jungheinrich's EAEa].
      - Managed and enhanced a commercial Behavior Tree-based framework, adopted by multinational companies for autonomous robot behavior development, contributing to the successful acquisition of the company.
    ][SCRUM, SAFe, Product Owner, Product Requirements, Behavior Trees, VDA5050, ROS, Unity, Gazebo, GitLab, Docker, Testing Strategy]

    #job[Team Lead Behaviors & Reasoning][Jan 2018 - Mar 2022][Magazino GmbH | Munich][
      - Supervised a multidisciplinary team, specializing in robot behavior development, data analysis, and software QA.
      - Directed the team's contributions to the successful development and launch of three innovative products: #link("https://www.youtube.com/watch?v=GkgxTrbMg0s")[TORU], #link("https://www.youtube.com/watch?v=LX86Kj5-U3I")[SOTO], #link("https://www.youtube.com/watch?v=1FGD0V1_jPE")[ACROS.AI].
      - Ensured the delivery of high-quality software through robust testing, analysis, and agile development practices.
    ][Behavior trees, Automated planning, SW QA, Gazebo, Buildbot, Data Analysis, Jupyter, GCP.]
  ],
)

#pagebreak()

// ---------------------------------------------------------------- page 2
#grid(
  columns: (RULE, 1fr),
  side[
    #heading-l[Languages]

    #language("Italian", 5)
    #language("English", 5)
    #language("German", 4)
    #language("French", 2)

    #heading-l[Skills]

    #block(below: 10pt)[
      #list(
        spacing: 9pt,
        [Agile Development],
        [Nonviolent Communication],
        [Effective Leadership],
        [Python],
        [C++],
        [Prolog],
        [ROS],
        [Nix, NixOS],
      )
    ]

    #heading-l[Additional Experience]

    #extra[Author, maintainer and contributor of various open and closed source projects][#emph[Repositories]: #link("https://github.com/ros/diagnostics")[ros/diagnostics], #link("https://github.com/aiplan4eu/UP4ROS2")[UP4ROS2], #link("https://github.com/yuce/pyswip")[pyswip], #link("https://github.com/iocchi/PetriNetPlans")[PetriNetPlans], #link("https://github.com/ros/geometry2")[ros/geometry2], behavior_trees, robot_state_reasoning, topological_graph_planner, and others.]
    #extra[European Project Reviewer][#emph[Project]: #link("https://sciroc.org")[SciRoc] (EU-H2020)]
    #extra[SPC, PC and Reviewer for various international conferences][#emph[Conferences]: IJCAI, ECAI, AI\*IA, and others.]
    #extra[International Research Project Contributor][#emph[Projects]: AIPlan4EU (EU-H2020 funded project), RoboDevOps (Bavarian funded project)]
    #extra[Robocup 2013: Team Leader and coordination and behaviors developer of the SPQR team][#emph[Achieved 1st place at Iran Open 2013 & 3rd place at German Open 2013]]
  ],
  main[
    #job[Senior Robotics Software Engineer][Mar 2017 - Dec 2017][Magazino GmbH | Munich][
      - Led the development of behaviors, navigation, and deployment for #link("https://www.youtube.com/watch?v=GkgxTrbMg0s")[TORU], a state-of-the-art autonomous robot.
      - Contributed to TORU's recognition as Best ROS-Based Product in 2020 and Best Product at LogiMAT in 2018.
      - Played a key role in advancing TORU's capabilities, driving its adoption in commercial and industrial applications.
    ][ROS, Behavior Trees, Django, Diagnostics, Prolog, Error modeling and Handling.]

    #job[Robotics Software Engineer][Nov 2015 - Mar 2017][Magazino GmbH | Munich][
      - Developed advanced navigation algorithms and behaviors for autonomous robots.
      - Optimized robotic systems for improved performance, reliability, and adaptability in dynamic environments.
    ][ROS, Move Base, Topological Graph Planner, NetworkX, Django, Behavior Trees.]

    #heading-l[Selected Publications]

    #text(size: 12pt, weight: "medium", fill: maroon)[Patents]
    #v(2pt)
    #list(
      spacing: 7pt,
      [#emph[Testbench for robot behavior trees.] *G. Gemignani*, M. Maerz, C. Ngan. European Patent and Trademark Office, filed on May 7th, 2024.],
      [#emph[Tasking robots using a job data structure.] *G. Gemignani*, R. Mansilla Martin, M. Grimm, M. Maerz, M. Tenorth, C. Ngan. European Patent and Trademark Office, filed on May 7th, 2024.],
      [#emph[Capabilities for error categorization, reporting and introspection of a technical apparatus.] *G. Gemignani*, M. Grimm, M. Tenorth. European Patent and Trademark Office, filed on August 8th, 2021.],
      [#emph[Controlling an apparatus, e.g., a robot, with a behavior tree.] *G. Gemignani*. European Patent and Trademark Office, filed on February 4th, 2021.],
    )

    #v(4pt)
    #text(size: 12pt, weight: "medium", fill: maroon)[Papers]
    #v(2pt)
    #list(
      spacing: 7pt,
      [#emph[Planning for Automated Testing of Implicit Constraints in Behavior Trees.] U. Köckemann, D. Calisi, *G. Gemignani*, J. Renoux, and A. Saffiotti. International Conference on Automated Planning and Scheduling, ICAPS 2023.],
      [#emph[Dialogue with Robots to Support Symbiotic Autonomy.] A. Vanzo, D. Croce, E. Bastianelli, *G. Gemignani*, R. Basili, D. Nardi. Dialogues with Social Robots, pp. 331-342, 2017.],
      [#emph[Living with Robots: Interactive Environmental Knowledge Acquisition.] *G. Gemignani*, R. Capobianco, E. Bastianelli, D. D. Bloisi, L. Iocchi, D. Nardi. Robotics and Autonomous Systems, RAS 2016.],
      [#emph[Multi-Robot Search for a Moving Target: Integrating World Modeling, Task Assignment and Context.] F. Riccio, E. Borzi, *G. Gemignani*, and D. Nardi. International Conference on Intelligent Robots and Systems, IROS 2016. RoboCup Best Paper Award.],
    )

    #v(6pt)
    #link("https://g-gemignani.github.io/publications/")[...full list of publications]
  ],
)
