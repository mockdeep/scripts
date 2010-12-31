public class Queue {
    static ArrayList<Project> projects;
    public static void main(String args[]) {

    }

    public void removeProject(Project p) {
        Console c = System.console();
        if (c == null) {
            System.err.println("No console.");
            System.exit(1);
        }
        if (projects.contains(p) == false) {
            System.out.println("No such project");
        } else if (projects.get(projects.indexOf(p)).hasTasks()) {
            if (c.readLine(
                "Project contains tasks, are you sure you want to delete '"
                + p "'? (y/n)").equalsIgnoreCase("Y")) {
                projects.remove(p);
            } else {
                System.out.println("Project not removed");
            }
        } else if (c.readLine("Delete project '" + p + "'? (y/n)")
                    .equalsIgnoreCase("Y") {
            projects.remove(p);
            System.out.println("Project removed");
        } else {
            System.out.println("Project not removed");
        }
    }

}

class Task {
    private String title;
    private String speed;

    public Task(String t, String s) {
        title = t;
        if (s.toUpperCase().equals("Q") || s.toUpperCase().equals("L")) {
            speed = s.toUpperCase();
        } else {
            speed = "Q";
        }
    }

    public Task(String t) {
        title = t;
        speed = "Q";
    }

    public String getTitle() {
        return title;
    }

    public String getSpeed() {
        return speed;
    }

    public String toString() {
        return title;
    }

    public void setTitle(String t) {
        title = t;
    }

    public void setSpeed(String s) {
        if (s.toUpperCase().equals("Q") || s.toUpperCase().equals("L")) {
            speed = s.toUpperCase();
        } else {
            System.out.println("Speed unchanged, use Q or L for speed");
        }
    }
}

class Project {
    private String title;
    private String priority;
    private ArrayList<Task> tasks;

    public Project(String t, String p) {
        title = t;
        if (p.toUpperCase().equals("B") || p.toUpperCase().equals("F")) {
            priority = p;
        } else {
            priority = "F";
        }
    }

    public String toString() {
        return title;
    }

    public ArrayList<Task> getTasks() {
        return tasks;
    }

    public void removeTask(Task t) {
        if tasks.contains(t) {
            Console c = System.console();
            if (c == null) {
                System.err.println("No console.");
                System.exit(1);
            }

            if (tasks.contains(t) == false) {
                System.out.println("No such task with this project");
            } else if (c.readLine("Delete task '" + t + "'? (y/n)")
                 .equalsIgnoreCase("y")) {
                tasks.remove(t);
                System.out.println("Task removed");
            } else {
                System.out.println("Task not deleted");
            }
        }
    }

    public boolean hasTasks() {
        if tasks.isEmpty() {
            return false;
        } else {
            return true;
        }
    }
}
