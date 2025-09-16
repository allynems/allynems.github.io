import React, { useState, useEffect } from "react";

const sampleData = {
  name: "Allyne dos Santos",
  headline: "Product Manager | Data & Offshore Systems",
  about: "Product-minded engineer with experience building algorithms and digital products for offshore energy.",
  experience: [
    { title: "Product Ownership Coordinator, CSPO®", 
      company: "Deep Seed Solutions", 
      time: "Aug/2024 -- Aug/2025", 
      location: "Rio de Janeiro, RJ - Brazil", 
      bullets: ["Configured and automated Jira and Jira Service Management to streamline project workflows.",
                "Defined product vision and requirements while overseeing the definition of Done for deliverables."],
      context: ["In addition to managing backlog prioritization, I successfully coordinated the delivery of three major features and accelerated the revitalization of a valuable, complex, and broken feature that had been in development for three years.",
        "Participated in international visits to key clients in Europe alongside the executive team, contributing with business needs analysis and identifying opportunities for product evolution."
      ]},
    { title: "RD&I Senior Researcher", 
      company: "Deep Seed Solutions", 
      time: "Mar/2023 -- Aug/2024", 
      location: "Brazil", 
      bullets: ["Mapped and developed methodologies for new features inside the main product, enhancing software capabilities.",
                "Collaborated with industry stakeholders like Aker BP ASA and Karoon Energy Brasil, ensuring client needs were met.",
              "Engaged directly with clients to refine software solutions, fostering strong professional relationships."],
      context: []},
  ],
  education: [{ degree: "MSc Chemical Engineering", school: "Federal University of Rio de Janeiro (UFRJ)", time: "2017 - 2019" }],
  skills: ["Product Management", "Python", "Optimization"],
  contact: { email: "allynems@utlook.com", linkedin: "https://www.linkedin.com/in/allyne-dos-santos" }
};

export default function App() {
  const [data, setData] = useState(sampleData);
  const [theme, setTheme] = useState("light");

  useEffect(() => {
    document.documentElement.classList.toggle("dark", theme === "dark");
  }, [theme]);

  return (
    <div className="min-h-screen p-6 text-gray-900 dark:text-gray-100 bg-gray-50 dark:bg-gray-900">
      <div className="max-w-4xl mx-auto bg-white dark:bg-gray-800 p-6 rounded shadow">
        <header className="flex justify-between items-center mb-4">
          <h1 className="text-2xl font-bold">{data.name}</h1>
          <button onClick={() => setTheme(theme === "light" ? "dark" : "light")} className="px-2 py-1 border rounded">
            Toggle {theme === "light" ? "Dark" : "Light"}
          </button>
        </header>
        <h2 className="text-lg mb-4">{data.headline}</h2>
        <section className="mb-4">
          <h3 className="font-semibold">About</h3>
          <p>{data.about}</p>
        </section>
        <section className="mb-4">
          <h3 className="font-semibold">Experience</h3>
          {data.experience.map((exp, i) => (
            <div key={i} className="mb-2">
              <div className="font-medium">{exp.title} @ {exp.company}</div>
              <div className="text-sm text-gray-500">{exp.time} — {exp.location}</div>
              <ul className="list-disc ml-6 text-sm">
                {exp.bullets.map((b, j) => <li key={j}>{b}</li>)}
              </ul>
              <div className="text-sm text-gray-500">{exp.context}</div>
            </div>
          ))}
        </section>
        <section className="mb-4">
          <h3 className="font-semibold">Education</h3>
          {data.education.map((ed, i) => (
            <div key={i}>{ed.degree}, {ed.school} ({ed.time})</div>
          ))}
        </section>
        <section className="mb-4">
          <h3 className="font-semibold">Skills</h3>
          <ul className="flex gap-2 flex-wrap">
            {data.skills.map((s, i) => <li key={i} className="px-2 py-1 bg-gray-200 dark:bg-gray-700 rounded">{s}</li>)}
          </ul>
        </section>
        <section>
          <h3 className="font-semibold">Contact</h3>
          <div>Email: {data.contact.email}</div>
          <div><a href={data.contact.linkedin} target="_blank" rel="noreferrer">LinkedIn</a></div>
        </section>
      </div>
    </div>
  );
}
