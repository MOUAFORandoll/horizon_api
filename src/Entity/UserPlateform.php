<?php

namespace App\Entity;


use App\Repository\UserPlateformRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use ApiPlatform\Core\Annotation\ApiResource;
use App\Controller\UserCreateController;

use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

use ApiPlatform\Core\Annotation\ApiFilter;
use ApiPlatform\Core\Annotation\ApiProperty;
use ApiPlatform\Core\Bridge\Doctrine\Orm\Filter\SearchFilter;
use ApiPlatform\Core\Bridge\Doctrine\Orm\Filter\DateFilter;
use ApiPlatform\Core\Bridge\Doctrine\Orm\Filter\ExistsFilter;
use ApiPlatform\Core\Bridge\Doctrine\Orm\Filter\BooleanFilter;
use Symfony\Component\Serializer\Annotation\Groups;
use App\FunctionU\MyFunction;


#[ORM\Entity(repositoryClass: UserPlateformRepository::class)]
#[ApiResource(
    itemOperations: [
        'get' => [],
        'patch' => [
            'denormalization_context' => [
                'groups' => ['create:user']
            ],
            'controller' => UserCreateController::class
        ],
        'delete' => []
    ],
    collectionOperations: [
        'get' => [
            'normalization_context' => [
                'groups' => ['read:user']
            ],
            'security' => "is_granted('IS_AUTHENTICATED_FULLY')"
        ],
        'post' => [
            'denormalization_context' => [
                'groups' => ['create:user']
            ],
            'controller' => UserCreateController::class
        ]
    ]
)]
#[ApiFilter(
    SearchFilter::class,
    properties: [
        'id' => 'exact',

        'nom' => 'exact',
        'phone' => 'exact',
        'email' => 'exact',
        'typeUser' => 'exact'
    ]
)]
class UserPlateform implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: "integer")]
    private $id;

    #[ORM\Column(type: "string", length: 255)]
    #[Groups(["create:user", "read:user", "read:paiement"])]
    private $nom;

    #[ORM\Column(type: "string", length: 255, nullable: true)]
    #[Groups(["create:user", "read:user", "read:paiement"])]
    private $prenom;

    #[ORM\Column(type: "string", length: 255, nullable: true)]
    #[Groups(["create:user", "read:user"])]
    private $email;

    #[ORM\Column(type: "json")]
    private $roles = ['ROLE_USER'];

    #[ORM\Column(type: "integer", length: 255, unique: true)]
    #[Groups(["create:user", "read:user"])]
    private $phone;

    #[ORM\Column(type: "boolean")]
    #[Groups(["create:user", "read:user"])]
    private $status = true;

    #[ORM\Column(type: "string", length: 255)]
    #[Groups(["create:user"])]
    private $password;


    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private $dateCreated;


    #[ORM\Column(type: "string", length: 10000000000, nullable: true)]
    private $keySecret;


    #[ORM\OneToMany(mappedBy: 'user_plateform', targetEntity: UserObject::class)]
    private Collection $userObjects;

    #[ORM\OneToMany(mappedBy: 'admin', targetEntity: Employe::class)]
    private Collection $employes;

    #[ORM\OneToMany(mappedBy: 'admin', targetEntity: Paiement::class)]
    private Collection $paiements;


    public function __construct()
    {

        $this->dateCreated = new \DateTime();

        $this->status = false;
        $this->employes = new ArrayCollection();
        $this->paiements = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): self
    {
        $this->nom = $nom;

        return $this;
    }

    public function getPrenom(): ?string
    {
        return $this->prenom;
    }
    public function getNomComplet()
    {
        return $this->getNom() . ' ' . $this->getPreNom();
    }

    public function getProfile()
    {
        //     return count($this->getUserObjects())  == 0 ? '' : new MyFunction()->getBackendUrl() . '/images/users/' . $this->getUserObjects()->first()->getSrc();
    }

    /**
     * @return Collection<int, UserObject>
     */
    public function getUserObjects(): Collection
    {
        return $this->userObjects;
    }

    public function addUserObject(UserObject $userObject): static
    {
        if (!$this->userObjects->contains($userObject)) {
            $this->userObjects->add($userObject);
            $userObject->setUserPlateform($this);
        }

        return $this;
    }

    public function removeUserObject(UserObject $userObject): static
    {
        if ($this->userObjects->removeElement($userObject)) {
            // set the owning side to null (unless already changed)
            if ($userObject->getUserPlateform() === $this) {
                $userObject->setUserPlateform(null);
            }
        }

        return $this;
    }
    public function setPrenom(string $prenom): self
    {
        $this->prenom = $prenom;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }
    /**
     * @see UserInterface
     */
    public function getRoles(): array
    {
        $roles = $this->roles;
        // guarantee every user at least has ROLE_USER
        $roles[] = 'ROLE_USER';

        return array_unique($roles);
    }

    public function setRoles(array $roles): self
    {
        $this->roles = $roles;

        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(string $phone): self
    {
        $this->phone = $phone;

        return $this;
    }

    public function isStatus(): ?bool
    {
        return $this->status;
    }

    public function setStatus(bool $status): self
    {
        $this->status = $status;

        return $this;
    }

    /**
     * @see PasswordAuthenticatedUserInterface
     */
    public function getPassword(): string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }
    /**
     * Returning a salt is only needed, if you are not using a modern
     * hashing algorithm (e.g. bcrypt or sodium) in your security.yaml.
     *
     * @see UserInterface
     */
    public function getSalt(): ?string
    {
        return null;
    }

    /**
     * @see UserInterface
     */
    public function eraseCredentials()
    {
        // If you store any temporary, sensitive data on the user, clear it here
        // $this->plainPassword = null;
    }
    /**
     * A visual identifier that represents this user.
     *
     * @see UserInterface
     */
    public function   getUserIdentifier(): string
    {
        return (string) $this->phone;
    }

    /**
     * @deprecated since Symfony 5.3, use getUserIdentifier instead
     */
    public function getUsername(): string
    {
        return (string) $this->phone;
    }

    public function getDateCreated(): ?\DateTimeInterface
    {
        return $this->dateCreated;
    }

    public function setDateCreated(\DateTimeInterface $dateCreated): self
    {
        $this->dateCreated = $dateCreated;

        return $this;
    }

    public function getKeySecret(): ?string
    {
        return $this->keySecret;
    }

    public function setKeySecret(string $keySecret): self
    {
        $this->keySecret = $keySecret;

        return $this;
    }

    /**
     * @return Collection<int, Employe>
     */
    public function getEmployes(): Collection
    {
        return $this->employes;
    }

    public function addEmploye(Employe $employe): static
    {
        if (!$this->employes->contains($employe)) {
            $this->employes->add($employe);
            $employe->setAdmin($this);
        }

        return $this;
    }

    public function removeEmploye(Employe $employe): static
    {
        if ($this->employes->removeElement($employe)) {
            // set the owning side to null (unless already changed)
            if ($employe->getAdmin() === $this) {
                $employe->setAdmin(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Paiement>
     */
    public function getPaiements(): Collection
    {
        return $this->paiements;
    }

    public function addPaiement(Paiement $paiement): static
    {
        if (!$this->paiements->contains($paiement)) {
            $this->paiements->add($paiement);
            $paiement->setAdmin($this);
        }

        return $this;
    }

    public function removePaiement(Paiement $paiement): static
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getAdmin() === $this) {
                $paiement->setAdmin(null);
            }
        }

        return $this;
    }
}
